import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/supplier_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';

abstract interface class VrtRepo {
  AsyncValueOf<List<VrtForm>> fetchvrtList(
      int start,
    int? docStatus,
    String? search,);
    AsyncValueOf<List<SupplierNameForm>> supplierName();
    AsyncValueOf<List<String>> vehicleTypeList();

  AsyncValueOf<String> createVrt(VrtForm form);
  AsyncValueOf<String> submitVrt(VrtForm form);
  AsyncValueOf<String> updateVrt(VrtForm form);
  AsyncValueOf<String> rejectvrt(String name,String reason);
}
