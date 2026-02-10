import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Credits/data/credits_repo.dart';
import 'package:tgbc_app/features/Credits/model/credits_form.dart';

import 'package:injectable/injectable.dart';

typedef CreateCreditsCubit = NetworkRequestCubit<String, String>;
typedef CreateCreditsCubitState = NetworkRequestState<String>;

typedef CreditsListCubit
    = InfiniteListCubit<CreditsForm, String?, String?>;
typedef CreditsListCubitState = InfiniteListState<CreditsForm>;

typedef GetCreditsItemsCubit
    = NetworkRequestCubit<List<CreditsForm>, String?>;
typedef GetCreditsItemsState = NetworkRequestState<List<CreditsForm>>;

typedef CreditsvalidationCubit
    = NetworkRequestCubit<bool, Pair<String, CreditsForm>>;
typedef CreditsvalidationState = NetworkRequestState<bool>;

typedef SubmitCreditsCubit = NetworkRequestCubit<String, String?>;
typedef SubmitCreditsCubitState = NetworkRequestState<String>;

@lazySingleton
class CreditsBlocProvider {
  const CreditsBlocProvider(this.repo);

  final CreditsRepo repo;

  static CreditsBlocProvider get() => $sl.get<CreditsBlocProvider>();

  CreateCreditsCubit creditscreation() => CreateCreditsCubit(
        onRequest: (params, _) => repo.createCredits(barcodeScan: params!),
      );

  CreditsListCubit fetchcreditsList() => CreditsListCubit(
        requestInitial: (params, state) => repo.getCreditsList(0, params),
        requestMore: (params, state) =>
            repo.getCreditsList(state.curLength, params),
      );

  GetCreditsItemsCubit fetchCreditsItemLines() => GetCreditsItemsCubit(
        onRequest: (params, state) => repo.getCreditsItemLines(params),
      );

  CreditsvalidationCubit creditsValidation() => CreditsvalidationCubit(
      onRequest: (params, state) => repo.creditscomponentScanningValidation(
          params!.first, params.second));

  SubmitCreditsCubit creditsSubmission() => SubmitCreditsCubit(
        onRequest: (params, _) => repo.submitCredits(params),
      );
}
