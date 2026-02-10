import 'package:tgbc_app/features/dashboard/presentation/widgets/circular_count_display.dart';
import 'package:flutter/material.dart';

class SimpleCountCard extends StatelessWidget {
  const SimpleCountCard({super.key, 
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
    
    const border = BorderRadius.all(Radius.circular(10.0));
    return Card(
      margin: const  EdgeInsets.all(10),
      elevation: 6,
      shadowColor: const Color(0xFFFFA95F),
      shape: const  RoundedRectangleBorder(borderRadius: border),
      child: Container(
        decoration: const  BoxDecoration(
          borderRadius: border,
          boxShadow: [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius:  const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  Text(lastUpdatedTime, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CountDisplay(title: 'Today', count: isLoading ? '... ' : todayCount,formatCount: false)),
                Expanded(
                  child: CountDisplay(title: 'MTD', count: isLoading ? '...' : monthCount, formatCount: false)),
                Expanded(
                  child: CountDisplay(title: 'YTD', count: isLoading ? '...' : yearCount,formatCount: false))
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
