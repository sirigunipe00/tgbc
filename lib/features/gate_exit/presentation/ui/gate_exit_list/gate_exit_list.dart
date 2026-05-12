import 'package:tgbc_app/app/widgets/app_page_view2.dart';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/gate_exit/model/gate_exit.dart';
import 'package:tgbc_app/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/gate_exit/presentation/bloc/gate_exit_filter.dart';
import 'package:tgbc_app/features/gate_exit/presentation/widgets/gate_exit_widget.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/styles/icons.dart';
import 'package:tgbc_app/widgets/infinite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GateExitListScrn extends StatelessWidget {
  const GateExitListScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageView2<GateExitFilterCubit>(
      mode: PageMode2.gateexit,
      scaffoldBg: AppIcons.bgFrame2.path,
      backgroundColor: AppColors.shyMoment,
      onNew: () => AppRoute.newGateExit.push(context),
      onUpdateQuery: (value) {
        context.cubit<GateExitFilterCubit>().onSearch(value);
        fetchInital(context);
      },
      onUpdateStatus: (value) {
        context.cubit<GateExitFilterCubit>().onChangeStatus(value);
        fetchInital(context);
      },
      status: const ['All','Draft', 'Submitted','Cancelled'],
      child: RefreshIndicator(
        onRefresh: (){
          final filters = context.read<GateExitFilterCubit>().state;

          return context.cubit<GateExitsCubit>().fetchInitial(
            filters
          );
        },
        child: InfiniteListViewWidget<GateExitsCubit, GateExit>(
          childBuilder: (context, exit) => GateExitWidget(
            gateExit: exit,
            onTap: () =>
              AppRoute.newGateExit.push<bool?>(context, extra: exit.name),
            
          ),
          fetchInitial: () => fetchInital(context),
          fetchMore: () => fetchMore(context),
          emptyListText: 'No GateExits Found',
        ),
      ),
    );
  }

  void fetchInital(BuildContext context) {
    final filter = context.read<GateExitFilterCubit>().state;
    context.cubit<GateExitsCubit>().fetchInitial(filter);
  }

  void fetchMore(BuildContext context) {
    final filter = context.read<GateExitFilterCubit>().state;
    context.cubit<GateExitsCubit>().fetchMore(filter);
  }
}
