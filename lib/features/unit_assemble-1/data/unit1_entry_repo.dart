
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/unit_assemble-1/model/unit1_assembly_form.dart';

abstract interface class Unit1Repo {
  AsyncValueOf<String> createunitassembly({
    required String barcodeScan,
  });
AsyncValueOf<List<UnitassemblyForm>> getUnitassemblyList (int start, String? search);
AsyncValueOf<List<UnitassemblyForm>> getUnit1ItemLines (String? name);
AsyncValueOf<bool> u1componentScanningValidation(String docName, UnitassemblyForm form);
AsyncValueOf<String> submitunit1(String? docid);
AsyncValueOf<int> fetchToday();
}

