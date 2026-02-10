import 'package:tgbc_app/core/cubit/infinite_list/infinite_list_cubit.dart';
import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/core/di/injector.dart';
import 'package:tgbc_app/core/model/page_list_filters.dart';
import 'package:tgbc_app/features/gate_entry/data/gate_entry_repo.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:tgbc_app/features/gate_entry/model/purchase_order.dart';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

typedef GateEntriesCubit
    = InfiniteListCubit<GateEntry, PageListFilters, PageListFilters>;
typedef GateEntriesCubitState = InfiniteListState<GateEntry>;

typedef GateEntryDetails = NetworkRequestCubit<GateEntry, String>;
typedef GateEntryDetailsState = NetworkRequestState<GateEntry>;

typedef PurchaseOrders = NetworkRequestCubit<List<PurchaseOrder>, None>;
typedef PurchaseOrdersState = NetworkRequestState<List<PurchaseOrder>>;

@lazySingleton
class GateEntryBlocProvider {
  const GateEntryBlocProvider(this.repo);

  final GateEntryRepo repo;

  static GateEntryBlocProvider get() => $sl.get<GateEntryBlocProvider>();

  GateEntriesCubit createGateEntriesCubit() => GateEntriesCubit(
        requestInitial: (params, state) => repo.fetchEntries(1, 20, params!),
        requestMore: (params, state) => repo.fetchEntries(
            state.curLength + 1, state.curLength + 20, params!),
      );

  GateEntryDetails getDetails() => GateEntryDetails(
        onRequest: (params, _) => repo.getEntry(params!),
      );

  PurchaseOrders fetchPONumbers() => PurchaseOrders(
        onRequest: (_, __) => repo.fetchPONumbers(),
      );
}
