import 'package:tgbc_app/app/widgets/app_page_view2.dart';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:tgbc_app/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:tgbc_app/features/gate_entry/presentation/widgets/gate_entry_widget.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/styles/icons.dart';
import 'package:tgbc_app/widgets/infinite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GateEntryListScrn extends StatelessWidget {
  const GateEntryListScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageView2<GateEntryFilterCubit>(
      mode: PageMode2.gateentry,
      scaffoldBg: AppIcons.bgFrame1.path,
      backgroundColor: AppColors.marigoldDDust,
      onNew: () => AppRoute.newGateEntry.push<bool?>(context),
      onUpdateQuery: (value) {
        context.cubit<GateEntryFilterCubit>().onSearch(value);
        fetchInital(context);
      },
      onUpdateStatus: (value) {
        context.cubit<GateEntryFilterCubit>().onChangeStatus(value);
        fetchInital(context);
      },
      status: const ['All', 'Draft', 'Submitted', 'Cancelled'],
      child: RefreshIndicator(
        onRefresh: (){
          final filters = context.read<GateEntryFilterCubit>().state;

          return context.cubit<GateEntriesCubit>().fetchInitial(
            filters
          );
        },
        child: InfiniteListViewWidget<GateEntriesCubit, GateEntry>(
          childBuilder: (context, entry) => MultiBlocProvider(
          
            providers: [
              BlocProvider(
                
                create: (context) => GateEntryBlocProvider.get()
                  .fetchSupplierName()
                  ..request(entry.poNumber),
              ),
           
            ],
            child: GateEntryWidget(
              gateEntry: entry,
              onTap: () =>
                  AppRoute.newGateEntry.push<bool?>(context, extra: entry.name),
            ),
          ),
          fetchInitial: () => fetchInital(context),
          fetchMore: () => fetchMore(context),
          emptyListText: 'No GateEntries Found',
        ),
      ),
    );
  }

  void fetchInital(BuildContext context) {
    final filter = context.read<GateEntryFilterCubit>().state;
    context.cubit<GateEntriesCubit>().fetchInitial(filter);
  }

  void fetchMore(BuildContext context) {
    final filter = context.read<GateEntryFilterCubit>().state;
    context.cubit<GateEntriesCubit>().fetchMore(filter);
  }
}
