import 'package:tgbc_app/features/dashboard/presentation/widgets/currency_formatter.dart';
import 'package:flutter/material.dart';

class CountDisplay extends StatelessWidget {
  const CountDisplay({
    required this.title,
    required this.count,
    this.formatCount = true,
    super.key,
  });
  final String title;
  final String count;
  final bool formatCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Tooltip(
          message: count != '-1' ? CurrencyFormatter.formatNumber2(double.tryParse(count)) : 'NA',
          showDuration: const Duration(minutes: 1),
          child: Card(
            elevation: 6,
            shadowColor: const Color(0xFFFFA95F),
            shape: const  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(64))),
            child: Container(
              height: 90,
              width: 90,
              margin: const  EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(64)),
                  boxShadow: [
                    // BoxShadow(
                    //     blurRadius: 10, color: Colors.blue, offset: Offset(0, 5))
                  ]),
              child: Text(
                count != '-1' ? formatCount ? CurrencyFormatter.formatNumber(double.parse(count)) : count : 'NA',
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
