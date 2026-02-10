import 'dart:convert';
import 'dart:io';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/model/page_list_filters.dart';
import 'package:tgbc_app/features/gate_entry/data/gate_entry_repo.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:tgbc_app/features/gate_entry/model/new_gate_entry_form.dart';
import 'package:tgbc_app/features/gate_entry/model/purchase_order.dart';

import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: GateEntryRepo)
class GateEntryRepoImpl extends BaseApiRepository implements GateEntryRepo {
  const GateEntryRepoImpl(super.client);

  @override
  AsyncValueOf<List<GateEntry>> fetchEntries(
      int start, int end, PageListFilters filters) async {
    final requestConfig = RequestConfig(
      url: Urls.gateEntryList,
      parser: (json) {
        final data = json['message']['data'];
        if (data is Map<String, dynamic>) {
          return [GateEntry.fromJson(data)];
        } else {
          final listdata = data as List<dynamic>;
          return listdata.map((e) => GateEntry.fromJson(e)).toList();
        }
      },
      reqParams: {
        if (filters.query.containsValidValue && filters.query!.length >= 2) ...{
          'name': filters.query,
        },
        'status': filters.status,
        'startrow': start,
        'order_by': 'creation DESC',
        'endrow': end,
      },
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<GateEntry> getEntry(String name) async {
    final requestConfig = RequestConfig(
      url: Urls.getGateEntry,
      parser: (json) {
        final data = json['message']['data'] as List<dynamic>;
        return GateEntry.fromJson(data.firstOrNull);
      },
      reqParams: {'name': name},
    );
    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<List<PurchaseOrder>> fetchPONumbers() async {
    final requestConfig = RequestConfig(
      url: Urls.poList,
      parser: (json) {
        final data = json['message']['data'] as List<dynamic>;
        return data.map((e) => PurchaseOrder.fromJson(e)).toList();
      },
    );

    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<Pair<String, String>> createGateEntry(
      NewGateEntryForm form) async {
    final config = RequestConfig(
      url: Urls.newGateEntry,
      parser: (json) {
        final data = json['message']['data'];
        if (data is Map<String, dynamic>) {
          return data['name'] as String?;
        } else {
          final listData = data as List<dynamic>;
          return listData.first['name'] as String?;
        }
      },
      body: jsonEncode(form.toJson()),
    );
    $logger.devLog(config);

    final response = await post(config);
    return response.process((docNo) {
      final msgWithDocNo =
          """The Gate Entry details - "${docNo.data}" have been saved successfully. Please submit it before leaving""";
      return right(Pair(docNo.data.valueOrEmpty, msgWithDocNo));
    });
  }

  @override
  AsyncValueOf<Pair<String, String>> submitGateEntry(
      NewGateEntryForm form) async {
    final config = RequestConfig(
      url: Urls.submitGateEntry,
      parser: (json) {
        final data = json['message']['data'];
        if (data is Map<String, dynamic>) {
          return data['name'] as String?;
        } else {
          final listData = data as List<dynamic>;
          return listData.first['name'] as String?;
        }
      },
      body: jsonEncode(form.toJson()),
    );
    $logger.devLog(config);

    final response = await post(config);
    return response.process((docNo) {
      final msgWithDocNo =
          """Gate Entry ${docNo.data} is submitted successfully.""";
      return right(Pair(docNo.data.valueOrEmpty, msgWithDocNo));
    });
  }
}
