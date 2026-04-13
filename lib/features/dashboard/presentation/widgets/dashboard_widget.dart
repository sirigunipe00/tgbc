


import 'package:flutter/material.dart';

import 'package:tgbc_app/features/dashboard/data/model/dashboard_data.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/containerx_widget.dart';
import 'package:tgbc_app/styles/app_colors.dart';
import 'package:tgbc_app/styles/app_text_styles.dart';

class DashBoardWidget extends StatelessWidget {
  const DashBoardWidget({
    super.key,
    required this.feat,
  });

  final DashboardModel feat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(21)),
          border: Border.all(
            color: AppColors.grey,
            width: 1,
          )),
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: ContainerX(
              margin: EdgeInsets.zero,
              child: Center(
                child: Text(feat.count, style: AppTextStyles.h7Bold(context)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                feat.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.h8Bold(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
