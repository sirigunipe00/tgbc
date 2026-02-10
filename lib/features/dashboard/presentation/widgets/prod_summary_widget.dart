import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProdSummaryWidget extends StatelessWidget {
  const ProdSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'SUMMARY',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 12),

          
          BlocBuilder<SummaryCubit, SummaryState>(
            builder: (context, state) {
         
              return state.maybeWhen(
                success: (data) {
                  final td = data.td.toString();
                  final mtd = data.mtd.toString();
                  final ytd = data.ytd.toString();

                  debugPrint('Summary Data: td=$td, mtd=$mtd, ytd=$ytd');

                  return _buildValues(td: td, mtd: mtd, ytd: ytd);
                },
                failure: (error) => _buildCustom('NA'),
                loading: () => _buildCustom('...'),
                orElse: () => _buildCustom('...'),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildValues({required String td, required String mtd, required String ytd}) {
    return Row(
      children: [
        Expanded(
          child: SummaryCard(
            title: 'Today',
            tooltipMessage: td,
            value: CurrencyFormatter.formatNumber(num.tryParse(td) ?? 0),
          ),
        ),
        Expanded(
          child: SummaryCard(
            title: 'MTD',
            tooltipMessage: mtd,
            value: CurrencyFormatter.formatNumber(num.tryParse(mtd) ?? 0),
          ),
        ),
        Expanded(
          child: SummaryCard(
            title: 'YTD',
            tooltipMessage: ytd,
           value: ytd.toString().replaceAll(RegExp(r'\.0+$'), ''),
          ),
        ),
      ],
    );
  }

  Widget _buildCustom(String value) {
    return Row(
      children: [
        Expanded(child: SummaryCard(title: 'Today', value: value, tooltipMessage: value)),
        Expanded(child: SummaryCard(title: 'MTD', value: value, tooltipMessage: value)),
        Expanded(child: SummaryCard(title: 'YTD', value: value, tooltipMessage: value)),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String tooltipMessage;
  final String title;
  final String value;

  const SummaryCard({super.key, 
    required this.tooltipMessage,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
