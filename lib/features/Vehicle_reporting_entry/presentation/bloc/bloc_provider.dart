import 'package:tgbc_app/core/cubit/infinite_list/infinite_list_cubit.dart';
import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/core/di/injector.dart';
import 'package:tgbc_app/core/model/pair.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/data/vrt_repo.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/supplier_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

typedef GetVRTList
    = InfiniteListCubit<VrtForm,Pair<int?, String?>,Pair<int?, String?>>;
typedef GetVRTListState = InfiniteListState<GateEntry>;

typedef SupplierNameList = NetworkRequestCubit<List<SupplierNameForm>, None>;
typedef SupplierNameListState = NetworkRequestState<List<SupplierNameForm>>;

typedef VehicleTypeList = NetworkRequestCubit<List<String>, None>;
typedef VehicleTypeListState = NetworkRequestState<List<String>>;

typedef RejectVRt = NetworkRequestCubit<String, Pair<String,String>>;
typedef RejectVRtState = NetworkRequestState<String>;

// typedef GateEntryDetails = NetworkRequestCubit<GateEntry, String>;
// typedef GateEntryDetailsState = NetworkRequestState<GateEntry>;

// typedef PurchaseOrders = NetworkRequestCubit<List<PurchaseOrder>, None>;
// typedef PurchaseOrdersState = NetworkRequestState<List<PurchaseOrder>>;

@lazySingleton
class VRTBlocProvider {
  const VRTBlocProvider(this.repo);

  final VrtRepo repo;

  static VRTBlocProvider get() => $sl.get<VRTBlocProvider>();

  GetVRTList fetchVRTListCubit() => GetVRTList(
        requestInitial: (params, state) => repo.fetchvrtList(0,params!.first, params.second),
        requestMore: (params, state) => repo.fetchvrtList(
            state.curLength,params!.first,params.second),
      );
  SupplierNameList supplierNameList() => SupplierNameList(onRequest: (_, state) => repo.supplierName());

  VehicleTypeList vehicleTypeList() => VehicleTypeList(onRequest: (_, state) => repo.vehicleTypeList());

  RejectVRt rejectVRt() => RejectVRt(onRequest: (params, state) => repo.rejectvrt(params!.first, params.second),);

  // GateEntryDetails getDetails() => GateEntryDetails(
  //       onRequest: (params, _) => repo.getEntry(params!),
  //     );

  // PurchaseOrders fetchPONumbers() => PurchaseOrders(
  //       onRequest: (_, __) => repo.fetchPONumbers(),
  //     );
}
