import 'dart:io';

import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/core/utils/context_ext.dart';
import 'package:tgbc_app/features/puf/model/puf_form.dart';
import 'package:tgbc_app/features/puf/presentation/bloc/bloc_provider.dart';
import 'package:tgbc_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CompScanningWidget extends StatefulWidget {
  const CompScanningWidget({
    super.key,
    required this.component,
    required this.onScan,
    required this.docName,
    required this.onAttachment,
  });
  final String docName;
  final PufForm component;
  final void Function(String scanId) onScan;
  final void Function(File file) onAttachment;

  @override
  State<CompScanningWidget> createState() => _CompScanningWidgetState();
}

class _CompScanningWidgetState extends State<CompScanningWidget> {
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

    // if(widget.component.attachment != null) {
    //   selectedFile = widget.component.attachment.path;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetcomponentScanningValidationCubit,
        GetcomponentScanningValidationState>(
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          failure: (failure) => showErrorDialog(
            context,
            failure.error,
          ),
          success: (data) {
            iscomplete = hasScanValue;
            widget.onScan(scanVal ?? '');
          },
        );
      },
      builder: (_, state) {
        final isLoading =
            state.maybeWhen(orElse: () => false, loading: () => true);
        return ListTile(
          tileColor: iscomplete ? Colors.green[100] : Colors.white,
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
          trailing: 
          
          
          iscomplete
              ? widget.component.attachment != null
                  ? GestureDetector(
                      onTap: () => _showImagePreview(
                          context, widget.component.attachment ?? File('')),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text('View',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                )),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    )
                  : null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading) ...[
                      const LoadingIndicator()
                    ] else ...[
                      IconButton(
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
                      if (widget.component.attachment != null)
                        GestureDetector(
                          onTap: () => _showImagePreview(context, widget.component.attachment!),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Text('View',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline)),
                              ],
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
                            hasScanValue = true;
                          }
                          hasScanValue =
                              scanResult != null && scanResult != '-1';
                          if (context.mounted) {
                            context
                                .bloc<GetcomponentScanningValidationCubit>()
                                .request(Pair(widget.docName, line));
                          }
                        },
                      ),
                    ],
                  ],
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

  void _showImagePreview(BuildContext context, File attachment) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(attachment), // Display the uploaded image
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
