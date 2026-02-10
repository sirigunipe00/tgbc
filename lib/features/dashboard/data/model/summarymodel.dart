class SummaryModel {
  final double td;
  final double mtd;
  final double ytd;

  SummaryModel({
    required this.td,
    required this.mtd,
    required this.ytd,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      td: double.tryParse(json['td'].toString()) ?? 0,
      mtd: double.tryParse(json['mtd'].toString()) ?? 0,
      ytd: double.tryParse(json['ytd'].toString()) ?? 0,
    );
  }
}
