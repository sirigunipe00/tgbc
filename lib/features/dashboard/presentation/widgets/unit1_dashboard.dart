// import 'package:cooltech/core/cubit/network_request/network_request_cubit.dart';
// import 'package:cooltech/features/dashboard/data/model/dashboard_hourly.dart';
// import 'package:cooltech/features/dashboard/presentation/bloc/blocprovider.dart';
// import 'package:cooltech/features/dashboard/presentation/widgets/chart.dart';
// import 'package:cooltech/features/dashboard/presentation/widgets/prod_dashboard_card.dart';
// import 'package:cooltech/features/dashboard/presentation/widgets/simple_count_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// class Unit1DashBoard extends StatefulWidget {
//   const Unit1DashBoard({super.key});

//   @override
//   _Unit1DashBoardState createState() => _Unit1DashBoardState();
// }

// class _Unit1DashBoardState extends State<Unit1DashBoard> {
//   late final CreditsYear _creditYearCubit;
//   late final CreditsMonth _creditMonthCubit;
//   late final CreditsToday _creditTodayCubit;

//   @override
//   void initState() {
//     super.initState();

//     final blocProvider = DashboardBlocProvider.get();
//     _creditYearCubit = blocProvider.creditYear();
//     _creditMonthCubit = blocProvider.creditMonth();
//     _creditTodayCubit = blocProvider.creditToday();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchDashboardData();
//     });

//     _creditMonthCubit.stream.listen((state) {
//       debugPrint('Month Cubit emitted: $state');
//     });
//     _creditYearCubit.stream.listen((state) {
//       debugPrint('Year Cubit emitted: $state');
//     });
//     _creditTodayCubit.stream.listen((state) {
//       debugPrint('Today Cubit emitted: $state');
//     });
//   }

//   void _fetchDashboardData() {
//     _creditYearCubit.request();
//     _creditMonthCubit.request();
//     _creditTodayCubit.request();
//   }

//   Future<void> refreshDashboard() async {
//     _fetchDashboardData();
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   @override
//   void dispose() {
//     _creditYearCubit.close();
//     _creditMonthCubit.close();
//     _creditTodayCubit.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: refreshDashboard,
//       child: ListView(
//         padding: const EdgeInsets.all(12),
//         children: [

//              final isLoading = yearState.isLoading ||
//                           monthState.isLoading ||
//                           todayState.isLoading;
//                            BlocBuilder<CreditsCubit, CreditsState>(
//             builder: (context, state) {
         
//               return state.maybeWhen(
//                 success: (data) {
//                   final td = data.td.toString();
//                   final mtd = data.mtd.toString();
//                   final ytd = data.ytd.toString();

//                   debugPrint('Summary Data: td=$td, mtd=$mtd, ytd=$ytd');

//                   return _buildValues(td: td, mtd: mtd, ytd: ytd);
//                 },
//                 failure: (error) => _buildCustom('NA'),
//                 loading: () => _buildCustom('...'),
//                 orElse: () => _buildCustom('...'),
//               );
//             },

//                       return SimpleCountCard(
//                         isLoading: isLoading,
//                         color: Colors.white,
//                         title: 'Credits',
//                         lastUpdatedTime:
//                             'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//                         monthCount: monthCount.toString(),
//                         todayCount: todayCount.toString(),
//                         yearCount: yearCount.toString(),
//                       );
//                            ),

//                                BlocBuilder<PufCubit, PufState>(
//             builder: (context, state) {
         
//               return state.maybeWhen(
//                 success: (data) {
//                   final td = data.td.toString();
//                   final mtd = data.mtd.toString();
//                   final ytd = data.ytd.toString();

//                   debugPrint('Summary Data: td=$td, mtd=$mtd, ytd=$ytd');

//                   return _buildValues(td: td, mtd: mtd, ytd: ytd);
//                 },
//                 failure: (error) => _buildCustom('NA'),
//                 loading: () => _buildCustom('...'),
//                 orElse: () => _buildCustom('...'),
//               );
//             },

//                       return SimpleCountCard(
//                         isLoading: isLoading,
//                         color: Colors.white,
//                         title: 'Credits',
//                         lastUpdatedTime:
//                             'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//                         monthCount: monthCount.toString(),
//                         todayCount: todayCount.toString(),
//                         yearCount: yearCount.toString(),
//                       );
//                            ),
//           // BlocBuilder<CreditsYear, NetworkRequestState<int>>(
//           //   builder: (context, yearState) {
//           //     final yearCount = yearState.maybeWhen(
//           //       success: (data) {
//           //         debugPrint('Year Data Count: $data');
//           //         return data;
//           //       },
//           //       orElse: () => 0,
//           //     );

//           //     return BlocBuilder<CreditsMonth, NetworkRequestState<int>>(
//           //       builder: (context, monthState) {
//           //         final monthCount = monthState.maybeWhen(
//           //           initial: () => 0,
//           //           loading: () => 0,
//           //           success: (data) {
//           //             debugPrint('Month Data Count: $data');
//           //             return data;
//           //           },
//           //           orElse: () => 0,
//           //         );

//           //         return BlocBuilder<CreditsToday, NetworkRequestState<int>>(
//           //           builder: (context, todayState) {
//           //             final todayCount = todayState.maybeWhen(
//           //               initial: () => 0,
//           //               loading: () => 0,
//           //               success: (data) {
//           //                 debugPrint('Today Data Count: $data');
//           //                 return data;
//           //               },
//           //               orElse: () => 0,
//           //             );

//           //             final isLoading = yearState.isLoading ||
//           //                 monthState.isLoading ||
//           //                 todayState.isLoading;

//           //             return SimpleCountCard(
//           //               isLoading: isLoading,
//           //               color: Colors.white,
//           //               title: 'Credits',
//           //               lastUpdatedTime:
//           //                   'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//           //               monthCount: monthCount.toString(),
//           //               todayCount: todayCount.toString(),
//           //               yearCount: yearCount.toString(),
//           //             );
//           //           },
//           //         );
//           //       },
//           //     );
//           //   },
//           // ),
//           // const SizedBox(height: 5),
//           // BlocBuilder<PufYear, NetworkRequestState<int>>(
//           //   builder: (context, yearState) {
//           //     final yearCount = yearState.maybeWhen(
//           //       success: (data) {
//           //         debugPrint('PUF Year Data Count: $data');
//           //         return data;
//           //       },
//           //       orElse: () => 0,
//           //     );

//           //     return BlocBuilder<PufMonth, NetworkRequestState<int>>(
//           //       builder: (context, monthState) {
//           //         final monthCount = monthState.maybeWhen(
//           //           initial: () => 0,
//           //           loading: () => 0,
//           //           success: (data) {
//           //             debugPrint('PUF Month Data Count: $data');
//           //             return data;
//           //           },
//           //           orElse: () => 0,
//           //         );

//           //         return BlocBuilder<PufToday, NetworkRequestState<int>>(
//           //           builder: (context, todayState) {
//           //             final todayCount = todayState.maybeWhen(
//           //               initial: () => 0,
//           //               loading: () => 0,
//           //               success: (data) {
//           //                 debugPrint('PUF Today Data Count: $data');
//           //                 return data;
//           //               },
//           //               orElse: () => 0,
//           //             );

//           //             final isLoading = yearState.isLoading ||
//           //                 monthState.isLoading ||
//           //                 todayState.isLoading;

//           //             return SimpleCountCard(
//           //               isLoading: isLoading,
//           //               color: Colors.white,
//           //               title: 'PUF',
//           //               lastUpdatedTime:
//           //                   'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//           //               monthCount: monthCount.toString(),
//           //               todayCount: todayCount.toString(),
//           //               yearCount: yearCount.toString(),
//           //             );
//           //           },
//           //         );
//           //       },
//           //     );
//           //   },
//           // ),
//           const SizedBox(height: 5),
//           BlocBuilder<HourlyCubit, HourlyState>(
//             builder: (context, state) {
//               final isLoading = state.isLoading;

//               // Extract hourly data safely
//               final List<HourModal> data = state.maybeWhen(
//                 success: (data) => data,
//                 orElse: () => <HourModal>[],
//               );

//               // If there's no data
//               if (data.isEmpty) {
//                 return const Center(
//                   child: Text('No hourly data available'),
//                 );
//               }

//               // Split data into Morning (first half) and Afternoon (second half)
//               // final midIndex = (data.length / 2).ceil();
//               // final morningData = data.sublist(0, midIndex);
//               // final afternoonData = data.sublist(midIndex);
//               final morningData = data.where((d) {
//                 final hour = d.hour;
//                 return hour <= 12; // Include 12 PM in morning
//               }).toList();

//               final afternoonData = data.where((d) {
//                 final hour = d.hour;
//                 return hour > 12; // Start from 1 PM onwards
//               }).toList();

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ProdDashboardCard(
//                     color: Colors.white,
//                     title: 'PUF vs Credits - Morning',
//                     lastUpdated:
//                         'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//                     isLoading: isLoading,
//                     child: ProdBarChart(data: morningData),
//                   ),
//                   const SizedBox(height: 10),
//                   ProdDashboardCard(
//                     color: Colors.white,
//                     title: 'PUF vs Credits - Afternoon',
//                     lastUpdated:
//                         'As of ${DateFormat('h:mm a').format(DateTime.now())}',
//                     isLoading: isLoading,
//                     child: ProdBarChart(data: afternoonData),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tgbc_app/features/dashboard/data/model/dashboard_hourly.dart';
import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/chart.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/prod_dashboard_card.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/simple_count_card.dart';

class Unit1DashBoard extends StatefulWidget {
   final bool isRefreshing;
  const Unit1DashBoard({super.key,this.isRefreshing = false});

  @override
  _Unit1DashBoardState createState() => _Unit1DashBoardState();
}

class _Unit1DashBoardState extends State<Unit1DashBoard> {
  late final CreditsCubit _creditsCubit;
  late final PufCubit _pufCubit;
  late final HourlyCubit _hourlyCubit;

  @override
  void initState() {
    super.initState();
    final blocProvider = DashboardBlocProvider.get();
    _creditsCubit = blocProvider.fetchcredits();
    _pufCubit = blocProvider.fetchPuf();
    _hourlyCubit = blocProvider.fetchHourlyData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDashboardData();
    });
  }

  void _fetchDashboardData() {
    _creditsCubit.request();
    _pufCubit.request();
    _hourlyCubit.request();
  }

  Future<void> refreshDashboard() async {
    _fetchDashboardData();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _creditsCubit.close();
    _pufCubit.close();
    _hourlyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return RefreshIndicator(
      onRefresh: refreshDashboard,
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // ---- Credits Count ----
          BlocBuilder<CreditsCubit, CreditsState>(
            
            builder: (context, state) {
              final isLoading = state.isLoading || widget.isRefreshing;
              
              return state.maybeWhen(
                loading: () => const SimpleCountCard(
                  isLoading: true,
                  color: Colors.white,
                  title: 'Credits',
                  lastUpdatedTime: 'Loading...',
                  monthCount: '...',
                  todayCount: '...',
                  yearCount: '...',
                ),
                success: (data) {
                  return SimpleCountCard(
                    isLoading: isLoading,
                    color: Colors.white,
                    title: 'Credits',
                    lastUpdatedTime:
                        'As of ${DateFormat('h:mm a').format(DateTime.now())}',
                    monthCount: data.mtd.toString(),
                    todayCount: data.td.toString(),
                    yearCount: data.ytd.toString(),
                  );
                },
                failure: (error) => SimpleCountCard(
                  isLoading: isLoading,
                  color: Colors.white,
                  title: 'Credits',
                  lastUpdatedTime: 'Error',
                  monthCount: 'NA',
                  todayCount: 'NA',
                  yearCount: 'NA',
                ),
                orElse: () => const SimpleCountCard(
                  isLoading: true,
                  color: Colors.white,
                  title: 'Credits',
                  lastUpdatedTime: 'Loading...',
                  monthCount: '...',
                  todayCount: '...',
                  yearCount: '...',
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          // ---- PUF Count ----
          BlocBuilder<PufCubit, PufState>(
            builder: (context, state) {
              final isLoading = state.isLoading || widget.isRefreshing;
              return state.maybeWhen(
                loading: () => const SimpleCountCard(
                  isLoading: true,
                  color: Colors.white,
                  title: 'PUF',
                  lastUpdatedTime: 'Loading...',
                  monthCount: '...',
                  todayCount: '...',
                  yearCount: '...',
                ),
                success: (data) {
                  return SimpleCountCard(
                    isLoading: isLoading,
                    color: Colors.white,
                    title: 'PUF',
                    lastUpdatedTime:
                        'As of ${DateFormat('h:mm a').format(DateTime.now())}',
                    monthCount: data.mtd.toString(),
                    todayCount: data.td.toString(),
                    yearCount: data.ytd.toString(),
                  );
                },
                failure: (error) => SimpleCountCard(
                  isLoading: isLoading,
                  color: Colors.white,
                  title: 'PUF',
                  lastUpdatedTime: 'Error',
                  monthCount: 'NA',
                  todayCount: 'NA',
                  yearCount: 'NA',
                ),
                orElse: () => const SimpleCountCard(
                  isLoading: true,
                  color: Colors.white,
                  title: 'PUF',
                  lastUpdatedTime: 'Loading...',
                  monthCount: '...',
                  todayCount: '...',
                  yearCount: '...',
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          // ---- Hourly Chart ----
          BlocBuilder<HourlyCubit, HourlyState>(
            builder: (context, state) {
              final isLoading = state.isLoading || widget.isRefreshing;
              final List<HourModal> data = state.maybeWhen(
                success: (data) => data,
                orElse: () => <HourModal>[],
              );

              if (data.isEmpty) {
                return const Center(child: Text('No hourly data available'));
              }

              final morningData = data.where((d) => d.hour <= 12).toList();
              final afternoonData = data.where((d) => d.hour > 12).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProdDashboardCard(
                    color: Colors.white,
                    title: 'PUF vs Credits - Morning',
                    lastUpdated:
                        'As of ${DateFormat('h:mm a').format(DateTime.now())}',
                    isLoading: isLoading,
                    child: ProdBarChart(data: morningData),
                  ),
                  const SizedBox(height: 10),
                  ProdDashboardCard(
                    color: Colors.white,
                    title: 'PUF vs Credits - Afternoon',
                    lastUpdated:
                        'As of ${DateFormat('h:mm a').format(DateTime.now())}',
                    isLoading: isLoading,
                    child: ProdBarChart(data: afternoonData),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
