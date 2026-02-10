import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/Credits/model/credits_form.dart';
import 'package:tgbc_app/features/Credits/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/Credits/presentation/ui/widgets/credits_scanning_widget.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/widgets/app_error_widget.dart';
import 'package:tgbc_app/widgets/loading_indicator.dart';
import 'package:tgbc_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreditsScreen extends StatefulWidget {
  final String item;
  final int docst;
  const CreditsScreen({super.key, required this.item, required this.docst});

  static void buildPage(BuildContext context, String itemm, int docsta) async {
    Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreditsBlocProvider.get().fetchcreditsList(),
            ),
            BlocProvider(
              create: (context) =>
                  CreditsBlocProvider.get().fetchCreditsItemLines()
                    ..request(itemm),
            ),
            BlocProvider(
              create: (context) =>
                  CreditsBlocProvider.get().creditsValidation(),
            ),
            BlocProvider(
              create: (context) =>
                  CreditsBlocProvider.get().creditsSubmission(),
            ),
          ],
          child: CreditsScreen(item: itemm, docst: docsta),
        );
      },
    )).then(
      (value) {
        context.cubit<CreditsListCubit>().fetchInitial('');
      },
    );
  }

  @override
  State<CreditsScreen> createState() => _CreditsScreenState();
}

class _CreditsScreenState extends State<CreditsScreen> {
  final lineItems = <CreditsForm>[];
  List<CreditsForm> completedLines = [];
  List<CreditsForm> validScanItems = [];

  // bool _hasRequestedCredits = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF87A2FF),
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
        child: BlocConsumer<GetCreditsItemsCubit, GetCreditsItemsState>(
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

                // if (lineItems.isEmpty && widget.docst != 1) {
                // context.bloc<SubmitCreditsCubit>().request(widget.item);
                // }
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
                  const Expanded(
                    child: Center(child: Text('No Components Found to Scan')),
                  ),
                ] else ...[
                  // BlocListener<SubmitCreditsCubit, SubmitCreditsCubitState>(
                    // listener: (context, st) {
                    //   st.maybeWhen(
                    //     orElse: () => false,
                    //     failure: (failure) =>
                    //         showErrorDialog(context, failure.error),
                    //     success: (data) => showSuccessDialog(context, data),
                    //   );
                    // },
                    // child: 
                    
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(height: 6.0),
                        padding: const EdgeInsets.all(8.0),
                        itemCount: lineItems.length,
                        itemBuilder: (ctxt, index) {
                          final component = lineItems[index];
                          return BlocProvider(
                            create: (_) => Unit2BlocProvider.get().unit2Validation(),
                            child: CreditsCompScanningWidget(
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
                                  final line = component.copyWith(scanVal: scanId);
                                  setState(() {
                                    lineItems
                                      ..removeAt(index)
                                      ..insert(index, line);
                                  });
                                  completedLines.add(line);
                                }
                                if (completedLines.length == lineItems.length) {
                                  // context
                                  //     .bloc<SubmitCreditsCubit>()
                                  //     .request(widget.item);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  // ),
                ],
                if (widget.docst != 1 && completedLines.length == lineItems.length) ...[
                  BlocConsumer<SubmitCreditsCubit, SubmitCreditsCubitState>(
                    listener: (context, state) {
                      state.maybeWhen(
                          orElse: () => false,
                          loading: () {
                            shouldAskForConfirmation.value = true;
                          },
                          failure: (failure) {
                            shouldAskForConfirmation.value = false;
                            showErrorDialog(context, failure.error);
                          },
                          success: (data) {
                            shouldAskForConfirmation.value = false;
                            return AppDialog.showSuccessDialog(context,
                                    content: data, onTapDismiss: context.pop)
                                .then((_) { 
                            
                              context.pop(true);
                            });
                          });
                    },
                    builder: (context, state) {
                      return AppButton(
                        label: 'Submit',
                        isLoading: state.isLoading,
                        onPressed: () {
                          context
                              .bloc<SubmitCreditsCubit>()
                              .request(widget.item);
                        },
                      );
                    },
                  )
                ],
                if (widget.docst == 1) ...[
                  const Center(child: Text('Document submitted..')),
                ]
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

  void fetchInitial(BuildContext context) {
    context.cubit<CreditsListCubit>().fetchInitial('');
  }

  void fetchMore(BuildContext context) {
    context.cubit<CreditsListCubit>().fetchMore('');
  }
}
