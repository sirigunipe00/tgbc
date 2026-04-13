
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tgbc_app/features/dashboard/data/model/dashboard_hourly.dart';
import 'package:tgbc_app/styles/styles.dart';


class ProdBarChart extends StatelessWidget {
  final List<HourModal> data;

  const ProdBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkModeEnabled(context);

    if (data.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No hourly data available')),
      );
    }

    final processedData = data
        .map((e) => HourModal(
              hour: e.hour,
              puf: (e.puf ?? 0) == 0 ? null : e.puf,
              credits: (e.credits ?? 0) == 0 ? null : e.credits,
            ))
        .toList();

    const double perHourWidth = 60;
    final double chartWidth = processedData.length * perHourWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: chartWidth < MediaQuery.of(context).size.width
              ? MediaQuery.of(context).size.width
              : chartWidth,
          height: 180,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            enableAxisAnimation: true,
            margin: EdgeInsets.zero,
            primaryXAxis: CategoryAxis(
              interval: 1,
              labelPlacement: LabelPlacement.betweenTicks,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0),
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            primaryYAxis: NumericAxis(
              isVisible: true,
              axisLine: const AxisLine(width: 0),
              labelStyle: const TextStyle(color: Colors.transparent),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 1),
              plotOffset: 0,
              axisLabelFormatter: (details) => ChartAxisLabel('', null),
            ),
            legend: const Legend(isVisible: true),

            series: <CartesianSeries<HourModal, String>>[
              ColumnSeries<HourModal, String>(
                name: 'PUF',
                dataSource: processedData,
                xValueMapper: (item, _) => item.hour.toString(),
                yValueMapper: (item, _) => item.puf,
                width: 0.7,
                spacing: 0.2,
                color: const Color(0xFF5b93ff),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.auto,
                  textStyle:
                      TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
              ColumnSeries<HourModal, String>(
                name: 'Credits',
                dataSource: processedData,
                xValueMapper: (item, _) => item.hour.toString(),
                yValueMapper: (item, _) => item.credits,
                width: 0.7,
                spacing: 0.2,
                color: const Color(0xFFff8f6b),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.auto,
                  textStyle:
                      TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 8),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _Legend(color: Color(0xFF5b93ff), text: 'PUF'),
        //     SizedBox(width: 12),
        //     _Legend(color: Color(0xFFff8f6b), text: 'Credits'),
        //   ],
        // ),
        const SizedBox(height: 6),
        // Text(
        //   "Hourly Production Summary (Today)",
        //   style: TextStyle(
        //     fontSize: 13,
        //     fontWeight: FontWeight.bold,
        //     color: isDark ? Colors.white70 : Colors.black87,
        //   ),
        // ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;
  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
