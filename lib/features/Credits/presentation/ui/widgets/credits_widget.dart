import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/Credits/model/credits_form.dart';
import 'package:tgbc_app/features/Credits/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/puf/presentation/ui/widgets/puf_search_bar.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/widgets/buttons/app_btn.dart';
import 'package:tgbc_app/widgets/dialogs/app_dialogs.dart';
import 'package:tgbc_app/widgets/infinite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CreditsWidget extends StatefulWidget {
  const CreditsWidget({super.key});

  @override
  _CreditsWidgetState createState() => _CreditsWidgetState();
}

class _CreditsWidgetState extends State<CreditsWidget> {
  List<String> scannedMachines = [];

  // final player = AudioPlayer();

// Future<void> playScanSound() async {
//   await player.play(AssetSource('sounds/scanner.mp3'));
// }

  void onScan(BuildContext context) async {
    String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scan Machine',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      scanType: ScanType.barcode,
      cameraFace: CameraFace.back,
    );

    if (barcodeScanRes != null && barcodeScanRes != '-1') {
      //  await playScanSound();
      setState(() {
        scannedMachines.add(barcodeScanRes);
      });
      if (context.mounted) {
        context.bloc<CreateCreditsCubit>().request(barcodeScanRes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF87A2FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Credits',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.cubit<CreditsListCubit>().fetchInitial('');
              context.cubit<CreditsToday>().request();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Search Bar
                Expanded(
                  child: PufSearchBar(
                    inputType: TextInputType.number,
                    hintText: 'Search',
                    onCancel: () {
                      context.cubit<CreditsListCubit>().fetchInitial('');
                    },
                    onSearch: (q) {
                      context.cubit<CreditsListCubit>().fetchInitial(q);
                    },
                  ),
                ),
                const SizedBox(width: 8),

                MultiBlocListener(
                  listeners: [
                    BlocListener<CreateCreditsCubit, CreateCreditsCubitState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () => false,
                          success: (data) {
                            return AppDialog.showSuccessDialog(context,
                                    content: data, onTapDismiss: context.pop)
                                .then((_) {
                              if (context.mounted) {
                                context
                                    .cubit<CreditsListCubit>()
                                    .fetchInitial('');
                              }
                            });
                          },
                          failure: (failure) {
                            return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(failure.error,
                                    style: const TextStyle(),
                                    textAlign: TextAlign.center),
                                actions: [
                                  SizedBox(
                                    width: 150,
                                    child: AppButton(
                                      onPressed: Navigator.of(context).pop,
                                      label: 'OK',
                                      bgColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    BlocListener<SubmitCreditsCubit, SubmitCreditsCubitState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () => false,
                            loading: () {
                              shouldAskForConfirmation.value = true;
                            },
                            failure: (failure) {
                              shouldAskForConfirmation.value = false;
                              return AppDialog.showErrorDialog(context,
                                      content: failure.error,
                                      onTapDismiss: context.pop)
                                  .then(
                                (_) {
                                  if (context.mounted) {
                                    context.pop(true);
                                    context
                                        .read<CreditsListCubit>()
                                        .fetchInitial('');
                                  }
                                },
                              );
                            },
                            success: (data) {
                              shouldAskForConfirmation.value = false;
                              return AppDialog.showSuccessDialog(context,
                                      content: data, onTapDismiss: context.pop)
                                  .then((_) {
                                if (context.mounted) {
                                  context.pop(true);
                                  context
                                      .cubit<CreditsListCubit>()
                                      .fetchInitial('');
                                }
                              });
                            });
                      },
                    ),
                  ],
                  child: InkWell(
                      onTap: () => onScan(context),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.blue,
                          size: 30,
                        ),
                      )),
                )
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<CreditsToday, NetworkRequestState<int>>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 4),
                          state.when(
                            initial: () => const Text(
                              '...',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            loading: () => const Text(
                              '...',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            success: (count) => Text(
                              '$count',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            failure: (failure) => const Text(
                              'Error',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Last Update: ${DateFormat('HH:mm').format(DateTime.now())}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: RefreshIndicator(
                  onRefresh: () =>
                      context.cubit<CreditsListCubit>().fetchInitial(''),
                  child: InfiniteListViewWidget<CreditsListCubit, CreditsForm>(
                    childBuilder: (context, entry) {
                      return CreditsWidgetCard(form: entry);
                    },
                    fetchInitial: () => fetchInitial(context),
                    fetchMore: () => fetchMore(context),
                    emptyListText: 'No Credits Found',
                  ),
                ),
              ),
            ),
          ],
        ),
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

class CreditsWidgetCard extends StatelessWidget {
  final CreditsForm form;
  const CreditsWidgetCard({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoute.creditComp
          .push(context, extra: Pair(form.name ?? '', form.docstatus ?? 0))
          .then(
        (value) {
          if (context.mounted) {
            context.read<CreditsListCubit>().fetchInitial('');
          }
        },
      ),
      // CreditsScreen.buildPage(context, form.name ?? '', form.docstatus ?? 0),
      child: Card(
        color: form.docstatus == 1 ? Colors.green[100] : AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    form.name.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      DFU.ddMMyyyyFromStr(form.creation.toString()),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 10, 6, 0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                form.serialno.toString(),
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 6),
              Text(form.workorder.valueOrEmpty,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(form.productionplan.valueOrEmpty,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(form.bom.valueOrEmpty,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
