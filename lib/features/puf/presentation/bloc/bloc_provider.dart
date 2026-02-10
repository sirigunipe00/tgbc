import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/puf/data/puf_entry_repo.dart';
import 'package:tgbc_app/features/puf/model/puf_form.dart';

import 'package:injectable/injectable.dart';

typedef CreatePufCubit = NetworkRequestCubit<String, String>;
typedef CreatePufCubitState = NetworkRequestState<String>;

typedef PufListCubit = InfiniteListCubit<PufForm, String?, String?>;
typedef PufListCubitState = InfiniteListState<PufForm>;

typedef GetPufItemsCubit = NetworkRequestCubit<List<PufForm>, String?>;
typedef GetPufItemsState = NetworkRequestState<List<PufForm>>;

typedef GetcomponentScanningValidationCubit
    = NetworkRequestCubit<bool, Pair<String, PufForm>>;
typedef GetcomponentScanningValidationState = NetworkRequestState<bool>;

typedef SubmitPufCubit = NetworkRequestCubit<String, String?>;
typedef SubmitPufCubitState = NetworkRequestState<String>;

@lazySingleton
class PufBlocProvider {
  const PufBlocProvider(this.repo);

  final PufEntryRepo repo;

  static PufBlocProvider get() => $sl.get<PufBlocProvider>();

  CreatePufCubit pufcreation() => CreatePufCubit(
        onRequest: (params, _) => repo.createPufEntry(barcodeScan: params!),
      );

  PufListCubit fetchPufList() => PufListCubit(
        requestInitial: (params, state) => repo.getPufList(0, params),
        requestMore: (params, state) =>
            repo.getPufList(state.curLength, params),
      );

  GetPufItemsCubit fetchItemLines() => GetPufItemsCubit(
        onRequest: (params, state) => repo.getPufItemLines(params),
      );
  GetcomponentScanningValidationCubit scanningValidation() =>
      GetcomponentScanningValidationCubit(
          onRequest: (params, state) =>
              repo.componentScanningValidation(params!.first, params.second));

  SubmitPufCubit pufSubmission() => SubmitPufCubit(
        onRequest: (params, _) => repo.submitPuf(params),
      );
}
