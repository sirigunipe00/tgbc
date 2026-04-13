
import 'package:flutter/material.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/currency_formatter.dart';

class CountDisplay extends StatelessWidget {
  const CountDisplay({
    required this.title,
    required this.count,
    this.formatCount = true,
    super.key,
    this.color, // used for border & shadow
  });

  final String title;
  final String count;
  final bool formatCount;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final circleColor = color ?? Colors.grey;

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        // const SizedBox(height: 10),

        Tooltip(
          message: count != '-1'
              ? CurrencyFormatter.formatNumber2(double.tryParse(count))
              : 'NA',
          showDuration: const Duration(minutes: 1),

          child: Container(
            height: 90,
            width: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,

              /// ✅ Only Bottom Shadow
              border: Border.all(
                color: circleColor,
                width: 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: circleColor,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: const Offset(0, 3), // ✅ shadow pushed to bottom only
                ),
              ],
            ),

            child: Text(
              count != '-1'
                  ? (formatCount
                      ? CurrencyFormatter.formatNumber(double.parse(count))
                      : count)
                  : 'NA',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
