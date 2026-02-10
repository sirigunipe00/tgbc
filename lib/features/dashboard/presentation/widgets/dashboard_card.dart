import 'package:flutter/material.dart';

class ProdDashboardCard extends StatelessWidget {
  final String title;
  final String lastUpdated;
  // final List<HourModal> first;
  // final List<HourModal> second;

  const ProdDashboardCard({super.key, 
    required this.title,
    required this.lastUpdated,
    // required this.first,
    // required this.second,
  });

  @override
  Widget build(BuildContext context) {
    var border = const BorderRadius.all(Radius.circular(10.0));
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: border),
      child: Container(
        decoration: BoxDecoration(borderRadius: border, boxShadow: const []),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _buildHeader(context),
        const  SizedBox(height: 20),
          // ProdBarChart.withData(first: first, second: second)
        ]),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
        decoration: const  BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        padding: const EdgeInsets.all(16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Text(lastUpdated,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
        ]));
  }
}
