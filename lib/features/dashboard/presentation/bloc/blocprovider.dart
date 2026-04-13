
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/core/di/injector.dart';
import 'package:tgbc_app/features/dashboard/data/dashboard_repo.dart';
import 'package:tgbc_app/features/dashboard/data/model/credits_model.dart';
import 'package:tgbc_app/features/dashboard/data/model/dashboard_hourly.dart';
import 'package:tgbc_app/features/dashboard/data/model/puf_model.dart';
import 'package:tgbc_app/features/dashboard/data/model/summarymodel.dart';



mixin CreditsYear on NetworkRequestCubit<int, None> {}
mixin CreditsMonth on NetworkRequestCubit<int, None> {}
mixin CreditsToday on NetworkRequestCubit<int, None> {}

class DashboardBlocProviderMixin extends NetworkRequestCubit<int, None>
    with CreditsYear, CreditsMonth, CreditsToday {
  DashboardBlocProviderMixin({required super.onRequest});
}

mixin PufYear on NetworkRequestCubit<int, None> {}
mixin PufMonth on NetworkRequestCubit<int, None> {}
mixin PufToday on NetworkRequestCubit<int, None> {}

typedef SummaryCubit = NetworkRequestCubit<SummaryModel, None>;
typedef SummaryState = NetworkRequestState<SummaryModel>;

typedef CreditsCubit = NetworkRequestCubit<CreditsModel, None>;
typedef CreditsState = NetworkRequestState<CreditsModel>;



typedef  PufCubit = NetworkRequestCubit<PufModel, None>;
typedef PufState = NetworkRequestState<PufModel>;

typedef HourlyCubit = NetworkRequestCubit<List<HourModal>, None>;
typedef HourlyState = NetworkRequestState<List<HourModal>>;

class DashboardBlocProviderMixins extends NetworkRequestCubit<int, None>
    with PufYear, PufMonth, PufToday {
  DashboardBlocProviderMixins({required super.onRequest});
}


@lazySingleton
class DashboardBlocProvider {
  const DashboardBlocProvider(this.repo);

  final DashboardRepo repo;

  static DashboardBlocProvider get() => $sl.get<DashboardBlocProvider>();

  // CreditsYear creditYear() => DashboardBlocProviderMixin(
  //       onRequest: (_, __) => repo.fetchCreditsYear(),
  //     );

  // CreditsMonth creditMonth() => DashboardBlocProviderMixin(
  //       onRequest: (_, __) => repo.fetchCreditsMonth(),
  //     );

  // CreditsToday creditToday() => DashboardBlocProviderMixin(
  //       onRequest: (_, __) => repo.fetchCreditsToday(),
  //     );
  // PufYear pufYear() => DashboardBlocProviderMixins(
  //       onRequest: (_, __) => repo.fetchPufYear(),
  //     );

  PufCubit fetchPuf() => PufCubit(
        onRequest: (_, __) => repo.fetchPuf(),
      );

   CreditsCubit fetchcredits() => CreditsCubit (
        onRequest: (_, __) => repo.fetchCredits(),
      );
  SummaryCubit fetchSummary() => SummaryCubit(
        onRequest: (_, __) => repo.fetchSummaryCount(),
      );
  HourlyCubit fetchHourlyData() => HourlyCubit(
        onRequest: (_, __) => repo.fetchHour(),
      );
}