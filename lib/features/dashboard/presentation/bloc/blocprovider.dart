
import 'package:tgbc_app/core/cubit/network_request/network_request_cubit.dart';
import 'package:tgbc_app/core/di/injector.dart';
import 'package:tgbc_app/features/dashboard/data/dashboard_repo.dart';
import 'package:tgbc_app/features/dashboard/data/model/summarymodel.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';



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

class DashboardBlocProviderMixins extends NetworkRequestCubit<int, None>
    with PufYear, PufMonth, PufToday {
  DashboardBlocProviderMixins({required super.onRequest});
}


@lazySingleton
class DashboardBlocProvider {
  const DashboardBlocProvider(this.repo);

  final DashboardRepo repo;

  static DashboardBlocProvider get() => $sl.get<DashboardBlocProvider>();

  CreditsYear creditYear() => DashboardBlocProviderMixin(
        onRequest: (_, __) => repo.fetchCreditsYear(),
      );

  CreditsMonth creditMonth() => DashboardBlocProviderMixin(
        onRequest: (_, __) => repo.fetchCreditsMonth(),
      );

  CreditsToday creditToday() => DashboardBlocProviderMixin(
        onRequest: (_, __) => repo.fetchCreditsToday(),
      );
  PufYear pufYear() => DashboardBlocProviderMixins(
        onRequest: (_, __) => repo.fetchPufYear(),
      );

  PufMonth pufMonth() => DashboardBlocProviderMixins(
        onRequest: (_, __) => repo.fetchPufMonth(),
      );

  PufToday pufToday() => DashboardBlocProviderMixins(
        onRequest: (_, __) => repo.fetchPufToday(),
      );
  SummaryCubit fetchSummary() => SummaryCubit(
        onRequest: (_, __) => repo.fetchSummaryCount(),
      );
}