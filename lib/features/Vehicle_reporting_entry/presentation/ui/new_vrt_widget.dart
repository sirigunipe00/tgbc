
import 'dart:developer';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/vrt_cubit.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/vrt_filters.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/ui/vrt_form_widget.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewVRTWidget extends StatefulWidget {
  const NewVRTWidget({super.key});

  @override
  State<NewVRTWidget> createState() => _NewVRTWidget();
}

class _NewVRTWidget extends State<NewVRTWidget> {
  @override
  Widget build(BuildContext context) {
    final gateEntryState = context.read<CreateVrtCubit>().state;
    final newform = gateEntryState.form;
    final status = newform.docstatus;
    final name = newform.name;
    final isNew = gateEntryState.view == VrtView.create;
  return Scaffold(
      backgroundColor: AppColors.white,
      appBar: isNew
          ? const SimpleAppBar(title: 'New Vehicle Reporting Entry ')
          : TitleStatusAppBar(
              title: 'Vehicle Reporting Entry',
              docNo: name.valueOrEmpty,
              status: StringUtils.docStatus(status ?? 0),
              textColor: const Color.fromARGB(255, 128, 128, 128),
            ) as PreferredSizeWidget,
      body: BlocListener<CreateVrtCubit,
          CreateVrtState>(
        listener: (_, state) async {
          if (state.isSuccess && state.successMsg!.isNotNull) {
            AppDialog.showSuccessDialog(
              context,
              content: state.successMsg.valueOrEmpty,
              onTapDismiss: context.exit,
            ).then((_) {
              if (!context.mounted) return;

    final formState = context.read<CreateVrtCubit>().state;

    log('formState==:$formState');
              context.cubit<CreateVrtCubit>().errorHandled();
              final filters = context.read<VrtFiltersCubit>().state;
              context.cubit<GetVRTList>().fetchInitial(Pair(
                  StringUtils.docStatusInt(filters.status), filters.query));
              setState(() {

              });
            });
          }
          if (state.error.isNotNull) {
            await AppDialog.showErrorDialog(
              context,
              title: state.error!.title,
              content: state.error!.error,
              onTapDismiss: context.exit,
            );
            if (!context.mounted) return;
            context.cubit<CreateVrtCubit>().errorHandled();
            return;
          }
        },
        child: SingleChildScrollView(
          child: VrtFormWidget(key: ValueKey(status)),
        ),
      ),
    );
    
  }
}
