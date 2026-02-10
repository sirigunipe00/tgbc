
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/cubit/base/filters_cubit.dart';
import 'package:tgbc_app/core/model/page_list_filters.dart';


class GateEntryFilterCubit extends FiltersCubit {
  GateEntryFilterCubit() : super(PageListFilters.initial());

  @override
  void onChangeStatus(String status) {
    final newState = state.copyWith(status: status);
    emitSafeState(newState);
  }

  @override
  void onSearch([String? query]) {
    if(query.doesNotHaveValue) {
      emitSafeState(PageListFilters(status: state.status));
    } else {
      final newState = state.copyWith(query: query);
      emitSafeState(newState);
    }
  }
}