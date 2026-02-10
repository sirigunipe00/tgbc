import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/unit_assemble-2/data/unit2_entry_repo.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

typedef CreateUnit2Cubit = NetworkRequestCubit<String, String>;
typedef CreateUnit2CubitState = NetworkRequestState<String>;

typedef Unit2ListCubit = InfiniteListCubit<Unit2assemblyForm, String?, String?>;
typedef Unit2ListCubitState = InfiniteListState<Unit2assemblyForm>;

typedef GetUnit2ItemsCubit = NetworkRequestCubit<List<Unit2assemblyForm>, String?>;
typedef GetUnit2ItemsState = NetworkRequestState<List<Unit2assemblyForm>>;

typedef Unit2validationCubit
    = NetworkRequestCubit<bool, Pair<String, Unit2assemblyForm>>;
typedef Unit2validationState = NetworkRequestState<bool>;

typedef Unit2Today = NetworkRequestCubit<int, None>;
typedef Unit2State = NetworkRequestState<int>;

typedef SubmitUnit2Cubit = NetworkRequestCubit<String, String?>;
typedef SubmitUnit2CubitState = NetworkRequestState<String>;

@lazySingleton
class Unit2BlocProvider {
  const Unit2BlocProvider(this.repo);

  final Unit2Repo repo;

  static Unit2BlocProvider get() => $sl.get<Unit2BlocProvider>();

  CreateUnit2Cubit unit2creation() => CreateUnit2Cubit(
        onRequest: (params, _) => repo.createunitassembly(barcodeScan: params!),
      );

  Unit2ListCubit fetchUnit2List() => Unit2ListCubit(
        requestInitial: (params, state) => repo.getUnitassemblyList(0, params),
        requestMore: (params, state) =>
            repo.getUnitassemblyList(state.curLength, params),
      );

  GetUnit2ItemsCubit fetchUnit2ItemLines() => GetUnit2ItemsCubit(
        onRequest: (params, state) => repo.getUnit2ItemLines(params),
      );


  Unit2validationCubit unit2Validation() =>
      Unit2validationCubit(
          onRequest: (params, state) =>
              repo.u2componentScanningValidation(params!.first, params.second));

  SubmitUnit2Cubit unit2Submission() => SubmitUnit2Cubit(
        onRequest: (params, _) => repo.submitunit2(params),
      );
  Unit2Today unit2Today() => Unit2Today(
        onRequest: (_, __) => repo.unit2Today(),
      );
}
