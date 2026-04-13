
import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/dashboard/data/model/credits_model.dart';
import 'package:tgbc_app/features/dashboard/data/model/dashboard_hourly.dart';
import 'package:tgbc_app/features/dashboard/data/model/puf_model.dart';
import 'package:tgbc_app/features/dashboard/data/model/summarymodel.dart';



abstract interface class DashboardRepo {
  AsyncValueOf<CreditsModel> fetchCredits();



  // AsyncValueOf<int> fetchCreditsMonth();
  // AsyncValueOf<int> fetchCreditsToday();
  // AsyncValueOf<int> fetchPufYear();
  // AsyncValueOf<int> fetchPufMonth();
  AsyncValueOf<PufModel> fetchPuf();
  AsyncValueOf<SummaryModel> fetchSummaryCount();
  AsyncValueOf<List<HourModal>> fetchHour();
}