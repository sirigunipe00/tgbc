class CreditsModel {
  final double td;
  final double mtd;
  final double ytd;

  CreditsModel({
    required this.td,
    required this.mtd,
    required this.ytd,
  });

  factory CreditsModel.fromJson(Map<String, dynamic> json) {
    return CreditsModel(
      td: double.tryParse(json['today_count'].toString()) ?? 0,
      mtd: double.tryParse(json['mtd_count'].toString()) ?? 0,
      ytd: double.tryParse(json['ytd_count'].toString()) ?? 0,
    );
  }
}