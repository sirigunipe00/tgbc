import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Credits/data/credits_repo.dart';
import 'package:tgbc_app/features/Credits/model/credits_form.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CreditsRepo)
class CreditsRepoImpl extends BaseApiRepository implements CreditsRepo {
  const CreditsRepoImpl(super.client);

  @override
  AsyncValueOf<String> createCredits({
    required String barcodeScan,
  }) async {
    final config = RequestConfig(
      url: Urls.createCredits,
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
        final pufId = message?['credits_u1_id'];
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
  AsyncValueOf<List<CreditsForm>> getCreditsList(
    int start,
    String? search,
  ) async {
    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'];

        final listdata = data as List<dynamic>;
        return listdata.map((e) => CreditsForm.fromJson(e)).toList();
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
        'doctype': 'Credits U1',
        'fields': ["*"]
      },
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    $logger.devLog(requestConfig);

    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<List<CreditsForm>> getCreditsItemLines(String? name) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: "${Urls.getCreditsItemLines}/$name",
        parser: (json) {
          final data = json['data']['component__scanning'];

          final listdata = data as List<dynamic>;
          return listdata.map((e) => CreditsForm.fromJson(e)).toList();
        },
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      log('config:$config');
      final response = await get(config);
      log('components response---:$response');
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<bool>creditscomponentScanningValidation (
      String docName, CreditsForm form) async {

    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.unit1validation,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({
          "doctype": 'Credits U1',
          "doc_id": docName,
          "item": form.item,
          "scan_value": form.scanVal,
          "photo": form.attachment != null
              ? base64Encode(form.attachment!.readAsBytesSync())
              : '',
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      $logger.devLog('creditscomponentScanningValidation ---$config');
      final response = await post(config);
      return response.process((r) => right(true));
    });
  }

  @override
  AsyncValueOf<String> submitCredits(
    String? docid,
  ) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.unit1submit,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({"doctype": 'Credits U1', "doc_id": docid}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      log('submit CONFIG--- :$config');
      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }
}
