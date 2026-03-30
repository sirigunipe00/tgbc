import 'dart:developer';
import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/supplier_form.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/presentation/bloc/vrt_cubit.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/widgets/app_spacer.dart';
import 'package:tgbc_app/widgets/buttons/app_btn.dart';
import 'package:tgbc_app/widgets/inputs/compact_listtile.dart';
import 'package:tgbc_app/widgets/inputs/input_filed.dart';
import 'package:tgbc_app/widgets/inputs/search_dropdown_list.dart';
import 'package:tgbc_app/widgets/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VrtFormWidget extends StatefulWidget {
  const VrtFormWidget({super.key});

  @override
  State<VrtFormWidget> createState() => _VrtFormWidgetState();
}

class _VrtFormWidgetState extends State<VrtFormWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final formState = context.read<CreateVrtCubit>().state;
    final isCreating = formState.view == VrtView.create;
    final isCompleted = formState.view == VrtView.completed;
    final isRejected = formState.view == VrtView.rejected;
    final newform = formState.form;
    log('formState.view===${formState.view}');

    return SingleChildScrollView(
      controller: _scrollController,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        margin: const EdgeInsets.all(12.0),
        defaultHeight: 8,
        children: [
          InputField(
            readOnly: true,
            initialValue: newform.documentDate,
            title: 'Document Date',
            isRequired: true,
            borderColor: AppColors.grey,
            onChanged: (p0) {},
          ),
          BlocBuilder<SupplierNameList, SupplierNameListState>(
            builder: (_, state) {
              final names = state.maybeWhen(
                orElse: () => <SupplierNameForm>[],
                success: (data) => data,
              );
              return SearchDropDownList(
                color: AppColors.grey,
                items: names,
                key: UniqueKey(),
                defaultSelection: names
                    .where((e) => e.name == newform.transporterDetails)
                    .firstOrNull,
                title: 'Transporter Details',
                hint: 'Select Transporter',
                readOnly: isCompleted,
                isloading: state.isLoading,
                isMandatory: true,
                futureRequest: (p0) async {
                  final where = names.where((e) =>
                      e.name.containsIgnoreCase(p0) ||
                      e.supName.containsIgnoreCase(p0));
                  return where.toList();
                },
                headerBuilder: (_, item, __) => Text(item.supName),
                listItemBuilder: (_, item, __, ___) => CompactListTile(
                  title: item.name,
                  subtitle: item.supName,
                ),
                onSelected: (names) {
                  context
                      .cubit<CreateVrtCubit>()
                      .onValueChanged(transporterDetails: names.name);
                  setState(() {});
                },
              );
            },
          ),
          InputField(
            readOnly: isCompleted,
            initialValue: newform.vehicleNo,
            title: 'Vehicle Number',
            isRequired: true,
            borderColor: AppColors.grey,
            maxLength: 10,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            suffixIcon: const Icon(Icons.pin_outlined),
            onChanged: (vehicleNo) {
              context
                  .cubit<CreateVrtCubit>()
                  .onValueChanged(vehicleNo: vehicleNo);
            },
          ),
          BlocBuilder<VehicleTypeList, NetworkRequestState<List<String>>>(
            builder: (_, state) {
              final names = state.maybeWhen(
                orElse: () => <String>[],
                success: (data) => data,
              );
              return SearchDropDownList(
                color: AppColors.grey,
                closedFillColor: AppColors.grey,
                isMandatory: true,
                items: names,
                key: UniqueKey(),
                defaultSelection:
                    names.where((e) => e == newform.vehicleType).firstOrNull,
                title: 'Vehicle Type',
                hint: 'Select Vehicle Type',
                readOnly: isCompleted,
                isloading: state.isLoading,
                futureRequest: (p0) async {
                  final where = names.where((e) => e.containsIgnoreCase(p0));
                  return where.toList();
                },
                headerBuilder: (_, item, __) => Text(item),
                listItemBuilder: (_, item, __, ___) => CompactListTile(
                  title: item,
                ),
                onSelected: (names) {
                  context
                      .cubit<CreateVrtCubit>()
                      .onValueChanged(vehicleType: names);
                },
              );
            },
          ),
          InputField(
            isRequired: true,
            readOnly: isCompleted,
            initialValue: newform.driverName,
            onChanged: (p0) {
              context.cubit<CreateVrtCubit>().onValueChanged(driverName: p0);
            },
            title: 'Driver Name',
            borderColor: AppColors.grey,
          ),
          InputField(
            isRequired: true,
            readOnly: isCompleted,
            initialValue: newform.driverNumber,
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            inputType: TextInputType.number,
            onChanged: (p0) {
              context.cubit<CreateVrtCubit>().onValueChanged(driverNumber: p0);
            },
            title: 'Driver Number ',
            borderColor: AppColors.grey,
          ),

          InputField(
            readOnly: true,
            initialValue: formState.view == VrtView.rejected
                ? 'Rejected'
                : newform.tokeStatus ?? "Reported",
            title: 'token status',
            isRequired: true,
            borderColor: AppColors.grey,
            maxLength: 10,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            suffixIcon: const Icon(Icons.pin_outlined),
            onChanged: (vehicleNo) {
              // context
              //     .cubit<CreateVrtCubit>()
              //     .onValueChanged(vehicleNo: vehicleNo);
            },
          ),

          if (newform.tokeStatus == 'Rejected' || isRejected) ...[
            InputField(
              readOnly: true,
              initialValue: newform.rejectReason,
              title: 'Reject Reason',
              isRequired: true,
              borderColor: AppColors.grey,
              maxLength: 10,
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              suffixIcon: const Icon(Icons.pin_outlined),
              onChanged: (vehicleNo) {
                // context
                //     .cubit<CreateVrtCubit>()
                //     .onValueChanged(vehicleNo: vehicleNo);
              },
            ),
          ],
          AppSpacer.p8(),

          /// BUTTON SECTION
          if (newform.tokeStatus == 'Rejected' || isRejected) ...[
            const SizedBox()
          ] else ...[
            BlocBuilder<CreateVrtCubit, CreateVrtState>(
                builder: (_, state) => AppButton(
                      label: isCreating
                          ? 'Create'
                          : isCompleted
                              ? 'Reject'
                              : 'Submit',
                      isLoading: state.isLoading,
                      bgColor: AppColors.haintBlue,
                      onPressed: () {
                        if (isCompleted) {
                          _showRejectDialog(context, state.form.name!);
                        } else {
                          context.cubit<CreateVrtCubit>().save();
                        }
                      },
                    )),
          ]
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, String docName) {
    showDialog(
      context: context,
      builder: (context) {
        return RejectDialog(docName: docName);
      },
    ).then(
      (value) {
        if (context.mounted) {
          context.cubit<CreateVrtCubit>()
            ..onValueChanged(rejectreason: value)
            ..save();
        }

        // context.cubit<CreateVrtCubit>().save();
      },
    );
  }
}

class RejectDialog extends StatelessWidget {
  final String docName;
  const RejectDialog({super.key, required this.docName});

  @override
  Widget build(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Reject Vehicle Reporting Entry'),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reject Reason *',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: reasonController,
                maxLines: 6,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enter reject reason',
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            final reason = reasonController.text.trim();
            if (reason.isNotEmpty) {
              // context.cubit<CreateVrtCubit>().onValueChanged(rejectreason: reason);
              Navigator.of(context).pop(reason);
              // context.read<CreateVrtCubit>().save();

              // context.cubit<RejectVRt>().request(Pair(docName, reason));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a reject reason'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Reject', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
