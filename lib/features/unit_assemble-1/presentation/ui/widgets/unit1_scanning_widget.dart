import 'dart:io';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/unit_assemble-1/model/unit1_assembly_form.dart';
import 'package:tgbc_app/features/unit_assemble-1/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class UnitCompScanningWidget extends StatefulWidget {
  const UnitCompScanningWidget({
    super.key,
    required this.component,
    required this.onScan,
    required this.docName,
    required this.onAttachment,
  });
  final String docName;
  final UnitassemblyForm component;
  final void Function(String scanId) onScan;
  final void Function(File file) onAttachment;

  @override
  State<UnitCompScanningWidget> createState() => _UnitCompScanningWidgetState();
}

class _UnitCompScanningWidgetState extends State<UnitCompScanningWidget> {
  String? scanVal;
  bool iscomplete = false;
  bool hasScanValue = false;
  bool hasAttachment = false;
  XFile? selectedFile;

  bool get _attachmentPresent {
    final ds = widget.component.docstatus ?? 0;
    if (ds == 1) {
      return (widget.component.photo ?? '').trim().isNotEmpty;
    }
    return hasAttachment || widget.component.attachment != null;
  }

  @override
  void initState() {
    scanVal = widget.component.scanVal ?? '';
    final hasscanValue = widget.component.scanVal ?? '';
    hasScanValue = hasscanValue.trim().isNotEmpty;
    hasAttachment = widget.component.attachment != null ||
        (widget.component.photo ?? '').trim().isNotEmpty;
    if ((widget.component.isPhotoMandatory ?? 0) == 1) {
      iscomplete = hasScanValue && _attachmentPresent;
    } else {
      iscomplete = hasScanValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Unit1validationCubit, Unit1validationState>(
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          failure: (failure) {
            showErrorDialog(
              context,
              failure.error,
            );
          },
          success: (data) {
            setState(() {
              hasScanValue = true;
              if ((widget.component.isPhotoMandatory ?? 0) == 1) {
                iscomplete = hasScanValue && _attachmentPresent;
              } else {
                iscomplete = hasScanValue;
              }
            });
            widget.onScan(scanVal ?? '');
          },
        );
      },
      builder: (_, state) {
        final bool isSubmitted = (widget.component.docstatus ?? 0) == 1;
        
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
          trailing: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.isLoading) ...[
                        const LoadingIndicator()
                      ] else ...[
                        IconButton(
                          onPressed: isSubmitted
                              ? null
                              : () async {
                                  final selectedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (selectedFile != null) {
                                    setState(() {
                                      hasAttachment = true;
                                      if ((widget.component.isPhotoMandatory ?? 0) == 1) {
                                        iscomplete = hasScanValue && _attachmentPresent;
                                      } else {
                                        iscomplete = hasScanValue;
                                      }
                                    });
                                    widget.onAttachment(File(selectedFile.path));
                                  }
                                },
                          icon: Icon(
                            Icons.attachment,
                            color: (widget.component.isPhotoMandatory == 1 && _attachmentPresent)
                                ? Colors.green
                                : (widget.component.attachment != null
                                    ? Colors.blue
                                    : widget.component.isPhotoMandatory == 1
                                        ? Colors.red
                                        : Colors.grey),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.qr_code,
                            color: hasScanValue ? Colors.green : Colors.grey,
                          ),
                          onPressed: isSubmitted
                              ? null
                              : () async {
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

                                  if (scanResult != null && scanResult != '-1') {
                                    scanVal = scanResult;
                                    final line = widget.component.copyWith(scanVal: scanResult);
                                    if (context.mounted) {
                                      context
                                          .bloc<Unit1validationCubit>()
                                          .request(Pair(widget.docName, line));
                                    }
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
