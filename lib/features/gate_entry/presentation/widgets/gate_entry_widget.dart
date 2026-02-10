import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/gate_entry/model/gate_entry.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/styles/app_text_styles.dart';
import 'package:tgbc_app/styles/icons.dart';
import 'package:tgbc_app/widgets/app_spacer.dart';
import 'package:tgbc_app/widgets/buttons/app_view_btn.dart';
import 'package:tgbc_app/widgets/doc_status_widget.dart';
import 'package:tgbc_app/widgets/spaced_column.dart';
import 'package:flutter/material.dart';

class GateEntryWidget extends StatelessWidget {
  const GateEntryWidget({
    super.key,
    required this.gateEntry,
    required this.onTap,
  });

  final GateEntry gateEntry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: AppColors.marigoldDDust, width: 2)),
        child: Stack(
          children: [
            Positioned.fill(
              left: context.sizeOfWidth * 0.3,
              child: Image(
                image: AssetImage(AppIcons.gateEntryCurves.path),
                fit: BoxFit.fill,
              ),
            ),
            SpacedColumn(
              defaultHeight: 4,
              margin: const EdgeInsets.all(12),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(gateEntry.name,
                        style: AppTextStyles.titleLarge(context)
                            .copyWith(color: AppColors.black)),
                    Text(gateEntry.invoiceDate,
                        style: AppTextStyles.titleLarge(context)
                            .copyWith(color: AppColors.black)),
                  ],
                ),
                Text(gateEntry.poNumber,
                    style: AppTextStyles.titleLarge(context)
                        .copyWith(color: AppColors.black)),
                AppSpacer.p8(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewBtn(onPressed: onTap),
                    DocStatusWidget(status: gateEntry.status.valueOrEmpty)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
