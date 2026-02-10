import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/prod_summary_widget.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/unit1_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {

  // Cubits
  late final summaryCubit = DashboardBlocProvider.get().fetchSummary();
  late final creditMonthCubit = DashboardBlocProvider.get().creditMonth();
  late final creditYearCubit = DashboardBlocProvider.get().creditYear();
  late final creditTodayCubit = DashboardBlocProvider.get().creditToday();
  late final pufMonthCubit = DashboardBlocProvider.get().pufMonth();
  late final pufTodayCubit = DashboardBlocProvider.get().pufToday();
  late final pufYearCubit = DashboardBlocProvider.get().pufYear();

  int _refreshKey = 0; // unique key for rebuild

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  void _fetchAllData() {
    summaryCubit.request();
    creditMonthCubit.request();
    creditYearCubit.request();
    creditTodayCubit.request();
    pufMonthCubit.request();
    pufTodayCubit.request();
    pufYearCubit.request();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: summaryCubit),
        BlocProvider.value(value: creditMonthCubit),
        BlocProvider.value(value: creditYearCubit),
        BlocProvider.value(value: creditTodayCubit),
        BlocProvider.value(value: pufMonthCubit),
        BlocProvider.value(value: pufTodayCubit),
        BlocProvider.value(value: pufYearCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFA95F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Production Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                setState(() {
                  _refreshKey++; // rebuild widgets
                });
                _fetchAllData(); // call APIs again
              },
            ),
          ],
        ),
        body: KeyedSubtree(
          key: ValueKey(_refreshKey), // forces rebuild
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProdSummaryWidget(), // removed const
              Expanded(child: Unit1DashBoard()), // removed const
            ],
          ),
        ),
      ),
    );
  }

}
