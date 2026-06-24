import 'package:tgbc_app/core/cubit/infinite_list/infinite_list_cubit.dart';
import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/core/di/injector.dart';
import 'package:tgbc_app/core/model/page_list_filters.dart';
import 'package:tgbc_app/features/gate_exit/data/gate_exit_repo.dart';
import 'package:tgbc_app/features/gate_exit/model/gate_exit.dart';

import 'package:injectable/injectable.dart';

typedef GateExitsCubit = InfiniteListCubit<GateExit, PageListFilters, PageListFilters>;
typedef GateExitsCubitState = InfiniteListState<GateExit>;

typedef GateExitDetails = NetworkRequestCubit<GateExit, String>;
typedef GateExitDetailsState = NetworkRequestState<GateExit>;

typedef GetVehicleNumber = NetworkRequestCubit<String?, String>;
typedef GetVehicleNumberState = NetworkRequestState<String?>;

@lazySingleton
class GateExitBlocProvider {
  const GateExitBlocProvider(this.repo);

  final GateExitRepo repo;

  static GateExitBlocProvider get() => $sl.get<GateExitBlocProvider>();


  GateExitsCubit createGateExitsCubit() => GateExitsCubit(
    requestInitial: (params, state) => repo.fetchGateExits(1, 20, params ?? PageListFilters.initial() ),
    requestMore: (params, state) => repo.fetchGateExits(state.curLength + 1, state.curLength + 20,  params ?? PageListFilters.initial(),),
  );

  GateExitDetails getDetails() => GateExitDetails(
    onRequest: (params, _) => repo.getGateExit(params!),
  );

  GetVehicleNumber getVehicleNumber() => GetVehicleNumber(
    onRequest: (params, _) => repo.getvehicleNumber(params!),
  );
}