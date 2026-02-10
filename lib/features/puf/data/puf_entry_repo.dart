
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/puf/model/puf_form.dart';

abstract interface class PufEntryRepo {
  AsyncValueOf<String> createPufEntry({
    required String barcodeScan,
  });
AsyncValueOf<List<PufForm>> getPufList (int start, String? search);
AsyncValueOf<List<PufForm>> getPufItemLines (String? name);
AsyncValueOf<bool> componentScanningValidation(String docName, PufForm form);
AsyncValueOf<String> submitPuf(String? docid);




  
}

