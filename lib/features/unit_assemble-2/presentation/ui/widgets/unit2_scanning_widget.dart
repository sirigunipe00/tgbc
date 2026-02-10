import 'dart:io';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/unit_assemble-2/model/unit2_assembly_form.dart';
import 'package:tgbc_app/features/unit_assemble-2/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Unit2CompScanningWidget extends StatefulWidget {
  const Unit2CompScanningWidget({
    super.key,
    required this.component,
    required this.onScan,
    required this.docName,
    required this.onAttachment,
  });
  final String docName;
  final Unit2assemblyForm component;
  final void Function(String scanId) onScan;
  final void Function(File file) onAttachment;

  @override
  State<Unit2CompScanningWidget> createState() =>
      _Unit2CompScanningWidgetState();
}

class _Unit2CompScanningWidgetState extends State<Unit2CompScanningWidget> {
  String? scanVal;
  bool iscomplete = false;
  bool hasScanValue = false;
  XFile? selectedFile;

  @override
  void initState() {
    scanVal = widget.component.scanVal ?? '';
    final hasscanValue = widget.component.scanVal ?? '';
    hasScanValue = hasscanValue.trim().isNotEmpty;
    iscomplete = hasScanValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Unit2validationCubit, Unit2validationState>(
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          failure: (failure) => showErrorDialog(
            context,
            failure.error,
          ),
          success: (data) {
            setState(() {
              hasScanValue = true;
            });
            iscomplete = hasScanValue;
            widget.onScan(scanVal ?? '');
          },
        );
      },
      builder: (_, state) {
        return ListTile(
          tileColor: iscomplete ? Colors.green[300] : Colors.white,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          title: Text(
            widget.component.item ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitleTextStyle:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          subtitle: Text(widget.component.itemName ?? ''),
          trailing: iscomplete
              ? null
              : SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.isLoading) ...[
                        const LoadingIndicator()
                      ] else ...[
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              final selectedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (selectedFile != null) {
                                widget.onAttachment(File(selectedFile.path));
                              }
                            },
                            icon: Icon(
                              Icons.attachment,
                              color: widget.component.attachment != null
                                  ? Colors.blue
                                  : widget.component.isPhotoMandatory == 1
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.qr_code),
                          onPressed: () async {
                            final scanResult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SimpleBarcodeScannerPage(
                                  scanType: ScanType.barcode,
                                  appBarTitle: 'Scan Machine',
                                  isShowFlashIcon: true,
                                ),
                              ),
                            );
                            final line =
                                widget.component.copyWith(scanVal: scanResult);

                            if (scanResult != null && scanResult != '-1') {
                              scanVal = scanResult;
                            }
                            if (context.mounted) {
                              context
                                  .bloc<Unit2validationCubit>()
                                  .request(Pair(widget.docName, line));
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
        );
      },
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
}
