import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/puf/presentation/ui/widgets/puf_search_bar.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/ui/widgets/unit_assembly_2_screen.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/widgets/buttons/app_btn.dart';
import 'package:tgbc_app/widgets/dialogs/app_dialogs.dart';
import 'package:tgbc_app/widgets/infinite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Unit2Widget extends StatefulWidget {
  const Unit2Widget({super.key});

  @override
  _Unit2WidgetState createState() => _Unit2WidgetState();
}

class _Unit2WidgetState extends State<Unit2Widget> {
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
      // await playScanSound();
      setState(() {
        scannedMachines.add(barcodeScanRes);
      });
      if (context.mounted) {
        context.bloc<CreateUnit2Cubit>().request(barcodeScanRes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2BCFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Unit Assembly - 2',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.cubit<Unit2ListCubit>().fetchInitial('');
              context.cubit<Unit2Today>().request();
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
                      context.cubit<Unit2ListCubit>().fetchInitial('');
                    },
                    onSearch: (q) {
                      context.cubit<Unit2ListCubit>().fetchInitial(q);
                    },
                  ),
                ),
                const SizedBox(width: 8),

                // Scan Icon Button
                BlocListener<CreateUnit2Cubit, CreateUnit2CubitState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () => false,
                      success: (data) {
                        return AppDialog.showSuccessDialog(context,
                                content: data, onTapDismiss: context.pop)
                            .then((_) {
                          if (context.mounted) {
                            context.cubit<Unit2ListCubit>().fetchInitial('');
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
                        ).then(
                          (value) {
                            if (context.mounted) {
                              context.cubit<Unit2ListCubit>().fetchInitial('');
                            }
                          },
                        );
                      },
                    );
                  },
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
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<Unit2Today, Unit2State>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha : 0.3),
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
                              'NA',
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
                  onRefresh: () async {
                    await context.cubit<Unit2ListCubit>().fetchInitial('');
                    await context.cubit<Unit2Today>().request();
                  },
                  child: InfiniteListViewWidget<Unit2ListCubit, Unit2assemblyForm>(
                    childBuilder: (context, entry) {
                      return Unit2WidgetCard(form: entry);
                    },
                    fetchInitial: () => fetchInitial(context),
                    fetchMore: () => fetchMore(context),
                    emptyListText: 'No UnitAssembly-2 Found',
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
    context.cubit<Unit2ListCubit>().fetchInitial('');
  }

  void fetchMore(BuildContext context) {
    context.cubit<Unit2ListCubit>().fetchMore('');
  }
}

class Unit2WidgetCard extends StatelessWidget {
  final Unit2assemblyForm form;
  const Unit2WidgetCard({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Unit2AssemblyScreen.buildPage(
          context, form.name ?? '', form.docstatus ?? 0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              Text(form.workorder.valueOrEmpty, style: const TextStyle(fontWeight: FontWeight.w500)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(form.productionplan.valueOrEmpty, style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(form.bom.valueOrEmpty, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
