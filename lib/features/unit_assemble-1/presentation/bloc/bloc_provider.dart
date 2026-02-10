import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/unit_assemble-1/data/unit1_entry_repo.dart';
import 'package:tgbc_app/features/unit_assemble-1/model/unit1_assembly_form.dart';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

typedef CreateUnit1Cubit = NetworkRequestCubit<String, String>;
typedef CreateUnit1CubitState = NetworkRequestState<String>;

typedef Unit1ListCubit = InfiniteListCubit<UnitassemblyForm, String?, String?>;
typedef Unit1ListCubitState = InfiniteListState<UnitassemblyForm>;

typedef GetUnit1ItemsCubit = NetworkRequestCubit<List<UnitassemblyForm>, String?>;
typedef GetUnit1ItemsState = NetworkRequestState<List<UnitassemblyForm>>;

typedef Unit1validationCubit
    = NetworkRequestCubit<bool, Pair<String, UnitassemblyForm>>;
typedef Unit1validationState = NetworkRequestState<bool>;

typedef UnitToday = NetworkRequestCubit<int, None>;
typedef UnitState = NetworkRequestState<int>;

typedef SubmitUnit1Cubit = NetworkRequestCubit<String, String?>;
typedef SubmitUnit1CubitState = NetworkRequestState<String>;

@lazySingleton
class Unit1BlocProvider {
  const Unit1BlocProvider(this.repo);

  final Unit1Repo repo;

  static Unit1BlocProvider get() => $sl.get<Unit1BlocProvider>();

  CreateUnit1Cubit unit1creation() => CreateUnit1Cubit(
        onRequest: (params, _) => repo.createunitassembly(barcodeScan: params!),
      );

  Unit1ListCubit fetchUnit1List() => Unit1ListCubit(
        requestInitial: (params, state) => repo.getUnitassemblyList(0, params),
        requestMore: (params, state) =>
            repo.getUnitassemblyList(state.curLength, params),
      );

  GetUnit1ItemsCubit fetchUnit1ItemLines() => GetUnit1ItemsCubit(
        onRequest: (params, state) => repo.getUnit1ItemLines(params),
      );


  Unit1validationCubit unitValidation() =>
      Unit1validationCubit(
          onRequest: (params, state) =>
              repo.u1componentScanningValidation(params!.first, params.second));

  SubmitUnit1Cubit unit1Submission() => SubmitUnit1Cubit(
        onRequest: (params, _) => repo.submitunit1(params),
      );
  UnitToday unitToday() => UnitToday(
        onRequest: (_, __) => repo.fetchToday(),
      );
}
