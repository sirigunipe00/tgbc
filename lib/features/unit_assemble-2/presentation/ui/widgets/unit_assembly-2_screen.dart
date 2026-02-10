import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/ui/widgets/unit2_scanning_widget.dart';
import 'package:tgbc_app/widgets/app_error_widget.dart';
import 'package:tgbc_app/widgets/buttons/app_btn.dart';
import 'package:tgbc_app/widgets/dialogs/app_dialogs.dart';
import 'package:tgbc_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Unit2AssemblyScreen extends StatefulWidget {
  final String item;
  final int docst;
  const Unit2AssemblyScreen(
      {super.key, required this.item, required this.docst});

  static void buildPage(BuildContext context, String itemm, int docsta) async {
    Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  Unit2BlocProvider.get().fetchUnit2ItemLines()..request(itemm),
            ),
            BlocProvider(
              create: (context) => Unit2BlocProvider.get().unit2Validation(),
            ),
            BlocProvider(
              create: (context) => Unit2BlocProvider.get().unit2Submission(),
            ),
          ],
          child: Unit2AssemblyScreen(item: itemm, docst: docsta),
        );
      },
    )).then(
      (value) {
        context.cubit<Unit2ListCubit>().fetchInitial('');
      },
    );
  }

  @override
  State<Unit2AssemblyScreen> createState() => _Unit2AssemblyScreenState();
}

class _Unit2AssemblyScreenState extends State<Unit2AssemblyScreen> {
  final lineItems = <Unit2assemblyForm>[];
  List<Unit2assemblyForm> completedLines = [];
  List<Unit2assemblyForm> validScanItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2BCFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.item,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<GetUnit2ItemsCubit, GetUnit2ItemsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: (data) {
                setState(() {
                  lineItems.addAll(data);
                  validScanItems.addAll(lineItems.where((item) =>
                      item.scanVal != null && item.scanVal!.isNotEmpty));
                  completedLines = validScanItems;
                });

                if (lineItems.isEmpty && widget.docst != 1) {
                  context.bloc<SubmitUnit2Cubit>().request(widget.item);
                }
              },
            );
          },
          builder: (_, state) {
            final isloading = state.maybeWhen(
              orElse: () => false,
              loading: () => true,
            );
            final isFailure = state.maybeWhen(
              orElse: () => null,
              failure: (failure) => failure,
            );

            if (isloading) {
              return const Center(child: LoadingIndicator());
            }

            if (isFailure != null) {
              return AppErrorWidget(error: isFailure.error);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (lineItems.isEmpty) ...[
                  Expanded(
                    child:
                        BlocListener<SubmitUnit2Cubit, SubmitUnit2CubitState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () => false,
                            failure: (failure) =>
                                showErrorDialog(context, failure.error),
                            success: (data) {
                              return AppDialog.showSuccessDialog(context,
                                      content: data, onTapDismiss: context.pop)
                                  .then((_) {
                             
                                context.pop(true);
                              });
                            });
                      },
                      child: const Center(
                          child: Text('No Components Found to Scan')),
                    ),
                  ),
                ] else ...[
                  BlocListener<SubmitUnit2Cubit, SubmitUnit2CubitState>(
                    listener: (context, st) {
                      st.maybeWhen(
                        orElse: () => false,
                        failure: (failure) =>
                            showErrorDialog(context, failure.error),
                        success: (data) => showSuccessDialog(context, data),
                      );
                    },
                    child: Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 6.0),
                        padding: const EdgeInsets.all(8.0),
                        itemCount: lineItems.length,
                        itemBuilder: (ctxt, index) {
                          final component = lineItems[index];
                          return BlocProvider(
                            create: (_) =>
                                Unit2BlocProvider.get().unit2Validation(),
                            child: Unit2CompScanningWidget(
                              component: component,
                              docName: widget.item,
                              onAttachment: (file) {
                                setState(() {
                                  final fileAttachment = file;
                                  final line = component.copyWith(
                                      attachment: fileAttachment);
                                  setState(() {
                                    lineItems
                                      ..removeAt(index)
                                      ..insert(index, line);
                                  });
                                });
                              },
                              onScan: (scanId) {
                                if (scanId.isNotEmpty) {
                                  final line =
                                      component.copyWith(scanVal: scanId);
                                  setState(() {
                                    lineItems
                                      ..removeAt(index)
                                      ..insert(index, line);
                                  });
                                  completedLines.add(line);
                                }
                                if (completedLines.length == lineItems.length) {
                                  context
                                      .bloc<SubmitUnit2Cubit>()
                                      .request(widget.item);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60),
            SizedBox(height: 10),
          ],
        ),
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64.0),
              border: Border.all(color: Colors.green, width: 4.0),
            ),
            padding: const EdgeInsets.all(32.0),
            child: const Icon(Icons.done, size: 48, color: Colors.green),
          ),
        ),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          SizedBox(
            width: 150,
            child: AppButton(
              onPressed: () => Navigator.of(context).pop(),
              label: 'OK',
              bgColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
