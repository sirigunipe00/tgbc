
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';

abstract interface class Unit2Repo {
  AsyncValueOf<String> createunitassembly({
    required String barcodeScan,
  });
AsyncValueOf<List<Unit2assemblyForm>> getUnitassemblyList (int start, String? search);
AsyncValueOf<List<Unit2assemblyForm>> getUnit2ItemLines (String? name);
AsyncValueOf<bool> u2componentScanningValidation(String docName, Unit2assemblyForm form);
AsyncValueOf<String> submitunit2(String? docid);
AsyncValueOf<int> unit2Today();




  
}

