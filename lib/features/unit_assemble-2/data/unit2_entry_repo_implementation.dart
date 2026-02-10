import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/unit_assemble-2/data/unit2_entry_repo.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: Unit2Repo)
class Unit2RepoImpl extends BaseApiRepository implements Unit2Repo {
  const Unit2RepoImpl(super.client);

  @override
  AsyncValueOf<String> createunitassembly({
    required String barcodeScan,
  }) async {
    final config = RequestConfig(
      url: Urls.create_unit_assembly2,
      parser: (json) {
        final message = json['message'];
        return message;
      },
      body: jsonEncode({
        'barcode_scan': barcodeScan,
      }),
    );
    $logger.devLog(config);

    final response = await post(config);
    return response.process((data) {
      final message = data.data;
      final messageObj = message?['message'];

      final status = message?['status'];

      if (status == 200) {
        final pufId = message?['unit_assembly_u2_id'];
        if (pufId != null) {
          return right(messageObj);
        }
      }

      return left(Failure(
        error: messageObj ?? 'Unknown error',
        status: status ?? 500,
      ));
    });
  }

  @override
  AsyncValueOf<List<Unit2assemblyForm>> getUnitassemblyList(
    int start,
    String? search,
  ) async {
    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'];

        final listdata = data as List<dynamic>;
        return listdata.map((e) => Unit2assemblyForm.fromJson(e)).toList();
      },
      reqParams: {
        // if (!(docStatus == null)) ...{
        'filters': [
          // ["docstatus", "=", docStatus],
          if (search.containsValidValue) ...{
            ["name", "Like", "%$search%"]
          }
        ],
        // },
        'limit_start': start,
        'limit': 20,
        'order_by': 'name DESC',
        'doctype': 'Unit Assembly 2 U1',
        'fields': ["*"]
      },
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    $logger.devLog(requestConfig);

    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<List<Unit2assemblyForm>> getUnit2ItemLines(String? name) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: "${Urls.getUnit2ItemLines}/$name",
        parser: (json) {
          final data = json['data']['component_scanning_unit_assembly_2'];

          final listdata = data as List<dynamic>;
          return listdata.map((e) => Unit2assemblyForm.fromJson(e)).toList();
        },
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      log('config:$config');
      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<bool>  u2componentScanningValidation (
      String docName, Unit2assemblyForm form) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.unit1validation,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({
          "doctype": 'Unit Assembly 2 U1',
          "doc_id": docName,
          "item": form.item,
          "scan_value": form.scanVal,
          "photo": form.attachment != null
              ? base64Encode(form.attachment!.readAsBytesSync())
              : '',
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      $logger.devLog('u2componentScanningValidationng val--$config');
      final response = await post(config);
      return response.process((r) => right(true));
    });
  }

  @override
  AsyncValueOf<String> submitunit2(
    String? docid,
  ) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.unit1submit,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({"doctype": 'Unit Assembly 2 U1', "doc_id": docid}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }

    @override
  AsyncValueOf<int> unit2Today() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    $logger.devLog('Fetching Today Credits for date: $today');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Unit Assembly 2 U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", "like", "$today%"]
        ],
        "limit_page_length": "None"
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length ?? 0;
      $logger.devLog('Today Credits fetched: $count items');
      if (count > 0) {
        // for (var e in r.data!.take(3)) {
        //   $logger.devLog('🔹 [Today] ${e.name} — ${e.creation}');
        // }
        return right(r.data!.length);
      }
      return right(0);
    });
  }
}
