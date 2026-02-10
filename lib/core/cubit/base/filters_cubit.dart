import 'package:tgbc_app/core/cubit/base/base_cubit.dart';
import 'package:tgbc_app/core/model/page_list_filters.dart';

abstract class FiltersCubit extends AppBaseCubit<PageListFilters> {
  FiltersCubit(super.initialState);
  void onSearch([String? query]);
  void onChangeStatus(String status);
}
