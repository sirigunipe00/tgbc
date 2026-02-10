import 'package:tgbc_app/app/widgets/app_page_view3.dart';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/vrt_filters.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/ui/widgets/vrt_widget.dart';
import 'package:tgbc_app/styles/icons.dart';
import 'package:tgbc_app/widgets/infinite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VrtListScreen extends StatelessWidget {
  const VrtListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageView3<VrtFiltersCubit>(
      mode: PageMode3.vrt,
      scaffoldBg: AppIcons.vRE.path,
      backgroundColor:const Color.fromARGB(255, 243, 232, 232),
      onNew: () => AppRoute.newVrt.push(context),
       onUpdateQuery: (value) {
        context.cubit<VrtFiltersCubit>().onSearch(value);
        _fetchInitial(context);
      },
       onUpdateStatus: (value) {
        context.cubit<VrtFiltersCubit>().onChangeStatus(value);
        _fetchInitial(context);
      },
      status: const ['Draft', 'Submitted'],
     child: InfiniteListViewWidget<GetVRTList, VrtForm>(
        childBuilder: (context, entry) => VrtWidget(
          vrt: entry,
          onTap: () => AppRoute.newVrt.push<bool?>(context, extra: entry),
        ),
        fetchInitial: () => _fetchInitial(context),
        fetchMore: () => _fetchMore(context),
        emptyListText: 'No Vehicle Reporting Entries Found',
      ),
    );
  }

  void _fetchInitial(BuildContext context) {
    final filters = context.read<VrtFiltersCubit>().state;
    context.cubit<GetVRTList>().fetchInitial(
        Pair(StringUtils.docStatusInt(filters.status), filters.query));
  }

  void _fetchMore(BuildContext context) {
    final filters = context.read<VrtFiltersCubit>().state;
    context.cubit<GetVRTList>().fetchMore(
        Pair(StringUtils.docStatusInt(filters.status), filters.query));
  }
}