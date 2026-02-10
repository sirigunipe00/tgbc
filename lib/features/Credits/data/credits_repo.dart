
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/Credits/model/credits_form.dart';

abstract interface class CreditsRepo {
  AsyncValueOf<String> createCredits({
    required String barcodeScan,
  });
AsyncValueOf<List<CreditsForm>> getCreditsList (int start, String? search);
AsyncValueOf<List<CreditsForm>> getCreditsItemLines (String? name);
AsyncValueOf<bool> creditscomponentScanningValidation(String docName, CreditsForm form);
AsyncValueOf<String> submitCredits(String? docid);




  
}

