
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgbc_app/features/dashboard/presentation/bloc/blocprovider.dart';
import 'package:tgbc_app/features/dashboard/presentation/widgets/unit1_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// class _DashboardScreenState extends State<DashboardScreen>
//     with SingleTickerProviderStateMixin {



 
//   // late final summaryCubit = DashboardBlocProvider.get().fetchSummary();
//   // late final creditMonthCubit = DashboardBlocProvider.get().creditMonth();
//   // late final creditYearCubit = DashboardBlocProvider.get().creditYear();
//   // late final creditTodayCubit = DashboardBlocProvider.get().creditToday();
//   // late final pufMonthCubit = DashboardBlocProvider.get().pufMonth();
//   late final pufCubit = DashboardBlocProvider.get().fetchPuf();
//   late final creditCubit = DashboardBlocProvider.get().fetchSummary();
//   // late final hourlyData = DashboardBlocProvider.get().fetchHourlyData();

//   // int _refreshKey = 0; 

//   @override
//   void initState() {
//     super.initState();
//     _fetchAllData();
//   }

//   void _fetchAllData() {

//     pufCubit.request();
//     creditCubit.request();
//     // creditYearCubit.request();
//     // creditTodayCubit.request();
//     // pufMonthCubit.request();
//     // pufTodayCubit.request();
//     // pufYearCubit.request();
//     // hourlyData.request();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF00d58a),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Production Dashboard',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: Colors.white),
//             onPressed: () {
//               // setState(() {
//               //   // _refreshKey++; 
//               // });
//               _fetchAllData(); 
//             },
//           ),
//         ],
//       ),
//       body:  Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // const ProdSummaryWidget(),
//         Expanded(
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) =>
//             DashboardBlocProvider.get().fetchSummary()
//             ),
//           BlocProvider(
//             create: (context) => DashboardBlocProvider.get().fetchHourlyData()..request(),
//           ),
//            BlocProvider(
//             create: (context) => DashboardBlocProvider.get().fetchPuf()..request(),
//           ),
//            BlocProvider(
//             create: (context) => DashboardBlocProvider.get().fetchcredits()..request(),
//           ),
          
//         ],
//         child: const Unit1DashBoard(),
//       ),
//     ),
          
//         ],
//       ),
//     );
//   }

// }
class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  
  final ValueNotifier<bool> _isRefreshing = ValueNotifier(false);

  late final pufCubit = DashboardBlocProvider.get().fetchPuf();
  late final creditCubit = DashboardBlocProvider.get().fetchSummary();

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  void _fetchAllData() async {
    _isRefreshing.value = true; // Start showing '...'
    await Future.wait([
      pufCubit.request(),
      creditCubit.request(),
    ]);
    Future.delayed(const Duration(milliseconds: 500), () {
      _isRefreshing.value = false; // Stop showing '...'
    });
  }

  @override
  void dispose() {
    _isRefreshing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00d58a),
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
            onPressed: _fetchAllData,
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _isRefreshing,
        builder: (context, isRefreshing, _) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DashboardBlocProvider.get().fetchSummary()..request()),
              BlocProvider(create: (context) => DashboardBlocProvider.get().fetchHourlyData()..request()),
              BlocProvider(create: (context) => DashboardBlocProvider.get().fetchPuf()..request()),
              BlocProvider(create: (context) => DashboardBlocProvider.get().fetchcredits()..request()),
            ],
            child: Unit1DashBoard(isRefreshing: isRefreshing),
          );
        },
      ),
    );
  }
}
