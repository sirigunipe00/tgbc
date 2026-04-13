class PufModel {
  final double td;
  final double mtd;
  final double ytd;

  PufModel({
    required this.td,
    required this.mtd,
    required this.ytd,
  });

  factory PufModel.fromJson(Map<String, dynamic> json) {
    return PufModel(
      td: double.tryParse(json['today_count'].toString()) ?? 0,
      mtd: double.tryParse(json['mtd_count'].toString()) ?? 0,
      ytd: double.tryParse(json['ytd_count'].toString()) ?? 0,
    );
  }
}
