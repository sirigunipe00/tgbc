import 'dart:convert';
import 'dart:io';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/data/vrt_repo.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/supplier_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';

import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: VrtRepo)
class VrtRepoImpl extends BaseApiRepository implements VrtRepo {
  const VrtRepoImpl(super.client);
  @override
  AsyncValueOf<List<SupplierNameForm>> supplierName() async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.supplierName,
        reqParams: {
          'fields': ['*'],
          'filters': [
            ["is_transporter", "=", "1"]
          ],
          'limit_page_length': 'None'
        },
        parser: (p0) {
          final data = p0['data'] as List<dynamic>;
          return data.map((e) => SupplierNameForm.fromJson(e)).toList();
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<List<String>> vehicleTypeList() {
    return executeSafely(() async {
      final config = RequestConfig(
        url: Urls.vehicleType,
        reqParams: {
          'fields': ['name'], // Request only the name field
          'limit_page_length': 'None',
        },
        parser: (po) {
          final data = po['data'] as List<dynamic>;
          return data
              .map((e) => (e as Map<String, dynamic>)['name'].toString())
              .toList();
        },
      );

      final response = await get(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<List<VrtForm>> fetchvrtList(
    int start,
    int? docStatus,
    String? search,
  ) async {
    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'];

        final listdata = data as List<dynamic>;
        return listdata.map((e) => VrtForm.fromJson(e)).toList();
      },
      reqParams: {
        if (!(docStatus == null)) ...{
          'filters': [
            ["docstatus", "=", docStatus],
            if (search.containsValidValue) ...{
              ["name", "Like", "%$search%"]
            }
          ],
        },
        'limit_start': start,
        'limit': 20,
        'order_by': 'creation DESC',
        'doctype': 'Vehicle Reporting Entry',
        'fields': ["*"]
      },
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    final response = await get(requestConfig);
    return response.process((r) => right(r.data!));
  }

  @override
  AsyncValueOf<String> createVrt(VrtForm form) async {
    return await executeSafely(() async {
      final formJson = VrtForm.toEncodedFormJson(form);
      formJson['document_date'] = DFU.toPostDate(form.documentDate);
      final config = RequestConfig(
          url: Urls.createVehicleReportingEntry,
          parser: (p0) => p0['message']['vehicle_reporting_entry_id'] as String,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonEncode(formJson));
      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
  AsyncValueOf<String> submitVrt(VrtForm form) async {
    await updateVrt(form.copyWith(name: form.name));
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.submitVehicleReportingEntry,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({"doc_name": form.name}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }

  @override
AsyncValueOf<String> updateVrt(VrtForm form) async {
  return await executeSafely(() async {
    final Map<String, dynamic> formJson = form.toJson();
      formJson['document_date'] = DFU.toPostDate(form.documentDate);

    // Safely ensure 'doc_name' is present
    // Replace 'name' with 'doc_name'
    final nameValue = formJson.remove('name'); // Remove 'name'
    formJson['doc_name'] = nameValue ?? form.name; // Add 'doc_name'

    final config = RequestConfig(
      url: Urls.updateVehicleReportingEntry,
      parser: (p0) => p0['message']['message'] as String,
      body: jsonEncode(formJson),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    $logger.devLog(config);

    final response = await post(config);
    return response.process((r) => right(r.data!));
  });
}
  @override
  AsyncValueOf<String> rejectvrt(String name,String reason) async {
    return await executeSafely(() async {
      final config = RequestConfig(
        url: Urls.rejectvrt,
        parser: (p0) => p0['message']['message'] as String,
        body: jsonEncode({
          "doc_name": name,
           "reject_reason":reason
        }),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );

      final response = await post(config);
      return response.process((r) => right(r.data!));
    });
  }

}
