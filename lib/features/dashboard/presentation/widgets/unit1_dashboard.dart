import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/simple_count_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Unit1DashBoard extends StatefulWidget {
  const Unit1DashBoard({super.key});

  @override
  _Unit1DashBoardState createState() => _Unit1DashBoardState();
}

class _Unit1DashBoardState extends State<Unit1DashBoard> {
  late final CreditsYear _creditYearCubit;
  late final CreditsMonth _creditMonthCubit;
  late final CreditsToday _creditTodayCubit;

  @override
  void initState() {
    super.initState();

    final blocProvider = DashboardBlocProvider.get();
    _creditYearCubit = blocProvider.creditYear();
    _creditMonthCubit = blocProvider.creditMonth();
    _creditTodayCubit = blocProvider.creditToday();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDashboardData();
    });

    _creditMonthCubit.stream.listen((state) {
      debugPrint('Month Cubit emitted: $state');
    });
    _creditYearCubit.stream.listen((state) {
      debugPrint('Year Cubit emitted: $state');
    });
    _creditTodayCubit.stream.listen((state) {
      debugPrint('Today Cubit emitted: $state');
    });
  }

  void _fetchDashboardData() {
    _creditYearCubit.request();
    _creditMonthCubit.request();
    _creditTodayCubit.request();
  }

  Future<void> refreshDashboard() async {
    _fetchDashboardData();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _creditYearCubit.close();
    _creditMonthCubit.close();
    _creditTodayCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshDashboard,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
      
          BlocBuilder<CreditsYear, NetworkRequestState<int>>(
            builder: (context, yearState) {
              final yearCount = yearState.maybeWhen(
                success: (data) {
                  debugPrint('Year Data Count: $data');
                  return data;
                },
                orElse: () => 0,
              );

              return BlocBuilder<CreditsMonth, NetworkRequestState<int>>(
                builder: (context, monthState) {
                  final monthCount = monthState.maybeWhen(
                    initial: () => 0,
                    loading: () => 0,
                    success: (data) {
                      debugPrint('Month Data Count: $data');
                      return data;
                    },
                    orElse: () => 0,
                  );

                  return BlocBuilder<CreditsToday, NetworkRequestState<int>>(
                    builder: (context, todayState) {
                      final todayCount = todayState.maybeWhen(
                        initial: () => 0,
                        loading: () => 0,
                        success: (data) {
                          debugPrint('Today Data Count: $data');
                          return data;
                        },
                        orElse: () => 0,
                      );

                      final isLoading = yearState.isLoading ||
                          monthState.isLoading ||
                          todayState.isLoading;

                      return SimpleCountCard(
                        isLoading: isLoading,
                        color: const Color(0xFFFFA95F),
                        title: 'Credits',
                        lastUpdatedTime:
                            'At ${DateFormat('h:mm a').format(DateTime.now())}',
                        monthCount: monthCount.toString(),
                        todayCount: todayCount.toString(),
                        yearCount: yearCount.toString(),
                      );
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 16),

          
          BlocBuilder<PufYear, NetworkRequestState<int>>(
            builder: (context, yearState) {
              final yearCount = yearState.maybeWhen(
                success: (data) {
                  debugPrint('PUF Year Data Count: $data');
                  return data;
                },
                orElse: () => 0,
              );

              return BlocBuilder<PufMonth, NetworkRequestState<int>>(
                builder: (context, monthState) {
                  final monthCount = monthState.maybeWhen(
                    initial: () => 0,
                    loading: () => 0,
                    success: (data) {
                      debugPrint('PUF Month Data Count: $data');
                      return data;
                    },
                    orElse: () => 0,
                  );

                  return BlocBuilder<PufToday, NetworkRequestState<int>>(
                    builder: (context, todayState) {
                      final todayCount = todayState.maybeWhen(
                        initial: () => 0,
                        loading: () => 0,
                        success: (data) {
                          debugPrint('PUF Today Data Count: $data');
                          return data;
                        },
                        orElse: () => 0,
                      );

                      final isLoading = yearState.isLoading ||
                          monthState.isLoading ||
                          todayState.isLoading;

                      return SimpleCountCard(
                        isLoading: isLoading,
                        color: const Color(0xFFFFA95F),
                        title: 'PUF',
                        lastUpdatedTime:
                            'At ${DateFormat('h:mm a').format(DateTime.now())}',
                        monthCount: monthCount.toString(),
                        todayCount: todayCount.toString(),
                        yearCount: yearCount.toString(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
