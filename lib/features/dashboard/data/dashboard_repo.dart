import 'package:tgbc_app/core/utils/utils.dart';
import 'package:tgbc_app/features/dashboard/data/model/summarymodel.dart';


abstract interface class DashboardRepo {
  AsyncValueOf<int> fetchCreditsYear();
  AsyncValueOf<int> fetchCreditsMonth();
  AsyncValueOf<int> fetchCreditsToday();
  AsyncValueOf<int> fetchPufYear();
  AsyncValueOf<int> fetchPufMonth();
  AsyncValueOf<int> fetchPufToday();
  AsyncValueOf<SummaryModel> fetchSummaryCount();
}