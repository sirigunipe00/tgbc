// ignore_for_file: non_constant_identifier_names

import 'package:tgbc_app/core/di/injector.dart';

final _reqisteredUrl = $sl.get<Urls>(instanceName: 'baseUrl');

class Urls {
  factory Urls.tgbcUAT() =>
      const Urls('https://tgbcnextuat.easycloud.co.in/api');
  factory Urls.local() => const Urls('http://157.180.125.6:8000/api');
  factory Urls.tgbcLive() => const Urls('https://livetgbcerp.easycloud.co.in/api');

  //https://rilcooltecherp.easycloud.co.in/app/home
  const Urls(this.url);

  final String url;

  static bool get isTest => Uri.parse(_reqisteredUrl.url)
      .authority
      .split('.')
      .first
      .toLowerCase()
      .contains('uat');

  static final baseUrl = _reqisteredUrl.url;
  static final jsonWs = '$baseUrl/resource';
  static final cusWs = '$baseUrl/method';

  static final appVersion = '$cusWs/easy_common.api.get_app_version';

  static final login = '$cusWs/login';
  static final getusers = '$cusWs/easygateentry.api.getUsers';
  static final gateEntryList = '$cusWs/easygateentry.api.getGateEntry';
  static final getGateEntry = '$cusWs/easygateentry.api.getGateEntryDetails';
  static final newGateEntry = '$cusWs/easygateentry.api.createGateEntry';
  static final submitGateEntry = '$cusWs/easygateentry.api.submitGateEntry';
  static final poList = '$cusWs/easygateentry.api.po_list';
  static final supplierName = '$jsonWs/Supplier';
  static final vehicleType = '$jsonWs/Vehicle Type Master';
  static final VehicleReportingEntry = '$jsonWs/Vehicle Reporting Entry';

  static final gateExitList = '$cusWs/easygateentry.api.getGateExit';
  static final getGateExit = '$cusWs/easygateentry.api.getGateExitDetails';
  static final newGateExit = '$cusWs/easygateentry.api.createGateExit';
  static final submitGateExit = '$cusWs/easygateentry.api.submitGateExit';
  static final getVehicleNumber = '$cusWs/easygateentry.api.getvehiclenumberfromsalesinvoice';
      
  static final createPuf = '$cusWs/tgbc.api.create_puf';
  static final getList = '$cusWs/frappe.client.get_list';
  static final componentScanningValidation =
      '$cusWs/tgbc.api.component_scanning_validation';
  static final submitDoctype = '$cusWs/tgbc.api.submit_doctype';
  static final createunitassembly =
      '$cusWs/tgbc.api.create_unit_assembly1';
  static final unit1validation =
      '$cusWs/tgbc.api.component_scanning_validation';
  static final unit1submit = '$cusWs/tgbc.api.submit_doctype';
  static final create_unit_assembly2 =
      '$cusWs/tgbc.api.create_unit_assembly2';
  static final createCredits = '$cusWs/tgbc.api.create_credits';
  static final createVehicleReportingEntry= '$cusWs/tgbc.api.create_vehicle_reporting_enty';
  static final submitVehicleReportingEntry= '$cusWs/tgbc.api.submit_vehicle_reporting_enty';
  static final updateVehicleReportingEntry= '$cusWs/tgbc.api.update_vehicle_reporting_enty';
  static final rejectvrt= '$cusWs/tgbc.api.reject_vehicle_reporting_enty';

  static final getPufItemLines = '$jsonWs/Puf U1';
  static final getUnit1ItemLines = '$jsonWs/Unit assembly 1 U1';
  static final getUnit2ItemLines = '$jsonWs/Unit Assembly 2 U1';
  static final getCreditsItemLines = '$jsonWs/Credits U1';

  // static final summaryCount = '$cusWs/tgbc.api.get_credits_summary';


  static final summaryCount = '$cusWs/tgbc.api.get_credits_summary';
  static final hourlyData = '$cusWs/tgbc.api.get_today_puf_vs_credits';
  static final pufData = '$cusWs/tgbc.api.get_puf_counts_mtd_today_ytd';
  static final creditsData = '$cusWs/tgbc.api.get_credits_counts_mtd_today_ytd';

  static filepath(String path) {
    return '${baseUrl.replaceAll('api', '')}/${path.replaceAll('/private', '').replaceAll("///", '/')}';
  }
}
