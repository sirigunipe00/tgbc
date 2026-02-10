import 'package:tgbc_app/core/core.dart';
import 'package:tgbc_app/features/dashboard/data/dashboard_repo.dart';
import 'package:tgbc_app/features/dashboard/data/model/summarymodel.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton(as: DashboardRepo)
class DashboardRepoimpl extends BaseApiRepository implements DashboardRepo {
  const DashboardRepoimpl(super.client);

  @override
  AsyncValueOf<int> fetchCreditsYear() async {
    final year = DateTime.now().year.toString();
    $logger.devLog('Fetching Year Credits for: $year');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Credits U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", "like", "$year%"]
        ],
        "limit_page_length": "None"
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length;
      $logger.devLog('Year Credits fetched: $count items');
     
        

        return right(r.data!.length);
  
    });
  }

  @override
  AsyncValueOf<int> fetchCreditsMonth() async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    $logger.devLog(
        'Fetching Month Credits from ${DateFormat('yyyy-MM-dd').format(firstDay)} to ${DateFormat('yyyy-MM-dd').format(lastDay)}');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Credits U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", ">=", DateFormat('yyyy-MM-dd').format(firstDay)],
          ["creation", "<=", DateFormat('yyyy-MM-dd').format(lastDay)],
        ],
        "limit_page_length": "None",
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length ?? 0;
      $logger.devLog('Month Credits fetched: $count items');
      if (count > 0) {

        return right(r.data!.length);
      }
      return right(0);
    });
  }

  @override
  AsyncValueOf<int> fetchCreditsToday() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    $logger.devLog('Fetching Today Credits for date: $today');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Credits U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", "like", "$today%"]
        ],
        "limit_page_length": "None"
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length ?? 0;
      $logger.devLog('Today Credits fetched: $count items');
      if (count > 0) {
      
        return right(r.data!.length);
      }
      return right(0);
    });
  }

  @override
  AsyncValueOf<int> fetchPufYear() async {
    final year = DateTime.now().year.toString();
    $logger.devLog('Fetching Year Credits for: $year');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Puf U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", "like", "$year%"]
        ],
        "limit_page_length": "None"
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length;
      $logger.devLog('Year Credits fetched: $count items');
   

     

        return right(r.data!.length);
    
    });
  }

  @override
  AsyncValueOf<int> fetchPufMonth() async {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);

    $logger.devLog(
        'Fetching Month Credits from ${DateFormat('yyyy-MM-dd').format(firstDay)} to ${DateFormat('yyyy-MM-dd').format(lastDay)}');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Puf U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", ">=", DateFormat('yyyy-MM-dd').format(firstDay)],
          ["creation", "<=", DateFormat('yyyy-MM-dd').format(lastDay)],
        ],
        "limit_page_length": "None",
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length ?? 0;
      $logger.devLog('Month Credits fetched: $count items');
      if (count > 0) {
       
        return right(r.data!.length);
      }
      return right(0);
    });
  }

  @override
  AsyncValueOf<int> fetchPufToday() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    $logger.devLog('Fetching Today Credits for date: $today');

    final requestConfig = RequestConfig(
      url: Urls.getList,
      parser: (json) {
        final data = json['message'] as List<dynamic>;
        return data;
      },
      reqParams: {
        "doctype": "Puf U1",
        "fields": "*",
        "filters": [
          ["docstatus", "=", 1],
          ["creation", "like", "$today%"]
        ],
        "limit_page_length": "None"
      },
    );

    final response = await get(requestConfig);
    return response.process((r) {
      final count = r.data?.length ?? 0;
      $logger.devLog('Today Credits fetched: $count items');
      if (count > 0) {
      
        return right(r.data!.length);
      }
      return right(0);
    });
  }
@override
  AsyncValueOf<SummaryModel> fetchSummaryCount() async {
  $logger.devLog('Fetching Summary Count');

  final requestConfig = RequestConfig(
    url: Urls.summaryCount,
    parser: (json) {
      final data = json['message']?['response']?['data'] as List<dynamic>? ?? [];

      if (data.isNotEmpty) {
        final first = data.first as Map<String, dynamic>;
        return SummaryModel(
          td: double.tryParse(first['td'].toString()) ?? 0,
          mtd: double.tryParse(first['mtd'].toString()) ?? 0,
          ytd: double.tryParse(first['ytd'].toString()) ?? 0,
        );
      }

      return SummaryModel(td: 0, mtd: 0, ytd: 0);
    },
  );

  final response = await get(requestConfig);

  return response.process((r) {
    $logger.devLog('Summary fetched: td=${r.data?.td}, mtd=${r.data?.mtd}, ytd=${r.data?.ytd}');
    return right(r.data!);
  });
}




}
