import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/Vehicle_reporting_entry/model/vrt_form.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/styles/app_text_styles.dart';
import 'package:tgbc_app/widgets/buttons/app_view_btn.dart';
import 'package:tgbc_app/widgets/doc_status_widget.dart';
import 'package:tgbc_app/widgets/spaced_column.dart';
import 'package:flutter/material.dart';

class VrtWidget extends StatelessWidget {
  const VrtWidget({
    super.key,
    required this.vrt,
    required this.onTap,
  });

  final VrtForm vrt;
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
            side: const BorderSide(color: AppColors.grey, width: 2)),
        child: Stack(
          children: [
            // Positioned.fill(
            //   left: context.sizeOfWidth * 0.3,
            //   child: Image(
            //     image: AssetImage(AppIcons.VRE.path),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            SpacedColumn(
              defaultHeight: 4,
              margin: const EdgeInsets.all(12),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vrt.name!,
                        style: AppTextStyles.titleLarge(context)
                            .copyWith(color: AppColors.black)),
                    Text(DFU.ddMMyyyyFromStr(vrt.documentDate!),
                        style: AppTextStyles.titleLarge(context)
                            .copyWith(color: AppColors.black)),
                  ],
                ),
                // Text(vrt.,
                //     style: AppTextStyles.titleLarge(context)
                //         .copyWith(color: AppColors.black)),
                // AppSpacer.p8(),
                Row(
                  children: [
                    Text(
                      'Token Status : ',
                      style: AppTextStyles.titleLarge(context).copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      vrt.tokeStatus ?? '',
                      style: AppTextStyles.titleLarge(context).copyWith(
                        color: (vrt.tokeStatus?.toLowerCase() == 'reported')
                            ? Colors.green
                            : (vrt.tokeStatus?.toLowerCase() == 'rejected')
                                ? Colors.red
                                : Colors.blue,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewBtn(onPressed: onTap),
                    DocStatusWidget(
                      status: StringUtils.docStatus(vrt.docstatus ?? 0),
                    )
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
