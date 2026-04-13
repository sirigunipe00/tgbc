import 'package:equatable/equatable.dart';

class HourModal extends Equatable {
  final int hour;
  final double? puf;
  final double? credits;

  const HourModal({
    required this.hour,
    required this.puf,
    required this.credits,
  });

  factory HourModal.fromJson(Map<String, dynamic> json) => HourModal(
        hour: json['hour'] is String
            ? int.tryParse(json['hour']) ?? 0
            : (json['hour'] ?? 0),
        puf: double.tryParse(json['puf'].toString()) ?? 0,
        credits: double.tryParse(json['credits'].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'hour': hour,
        'puf': puf,
        'credits': credits,
      };

  @override
  List<Object> get props => [hour, puf ?? '', credits ?? ''];

  @override
  bool get stringify => true;
}
