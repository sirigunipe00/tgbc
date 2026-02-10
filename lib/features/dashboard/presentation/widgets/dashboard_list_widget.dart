import 'package:flutter/material.dart';
import 'package:tgbc_app/features/dashboard/data/model/dashboard_data.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/dashboard_widget.dart';

class DashBoardGList extends StatelessWidget {
  const DashBoardGList({super.key});

  @override
  Widget build(BuildContext context) {
    final list = DashboardData.list;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 0.82,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final feat = list[index];
        return DashBoardWidget(feat: feat);
      },
    );
  }
}
