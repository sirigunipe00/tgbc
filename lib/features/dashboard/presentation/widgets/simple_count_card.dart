
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/circular_count_display.dart';

class SimpleCountCard extends StatelessWidget {
  const SimpleCountCard({
    super.key,
    required this.title,
    required this.lastUpdatedTime,
    required this.monthCount,
    required this.todayCount,
    required this.yearCount,
    required this.color,
    this.isLoading = false,
  });

  final String title;
  final String lastUpdatedTime;
  final String todayCount;
  final String monthCount;
  final String yearCount;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern(); 

String formatNumber(String value) {
  if (value.isEmpty) return '0';
  final numValue = num.tryParse(value);
  if (numValue == null) return value; 
  return numberFormat.format(numValue);
}
    const border = BorderRadius.all(Radius.circular(20.0));

    return Card(
      margin: const EdgeInsets.all(2),
      elevation: 6,
      shape: const RoundedRectangleBorder(borderRadius: border),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),border: Border.all(color: Colors.black.withOpacity(0.4),width: 0.5)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
           
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                  Text(lastUpdatedTime,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black)),
                     ],
                ),
              ),
               Divider(
              height: 0, 
              thickness: 0.5,
              color: Colors.black54.withOpacity(0.4),
            ),

              Row(
              children: [
                Expanded(
                    child: CountDisplay(
                  title: '',
                  count: isLoading ? '...' : formatNumber(todayCount),
                  formatCount: false,
                  color: const Color(0xFF5f95ff),
                )),
                Expanded(
                    child: CountDisplay(
                  title: '',
                  count: isLoading ? '...' : formatNumber(monthCount),
                  formatCount: false,
                  color: const Color(0xFF00d58a),
                )),
                Expanded(
                    child: CountDisplay(
                  title: '',
                  count: isLoading ? '...' : formatNumber(yearCount),
                  formatCount: false,
                  color: const Color(0xFFff9978),
                )),
              ],
            ),

            const SizedBox(height: 15),

          
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                _LegendItem(label: 'Today', color: Color(0xFF5f95ff)),
                _LegendItem(label: 'MTD', color: Color(0xFF00d58a)),
                _LegendItem(label: 'YTD', color: Color(0xFFff9978)),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendItem({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.rectangle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
