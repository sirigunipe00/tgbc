import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit1_entry.freezed.dart';
part 'unit1_entry.g.dart';

@freezed
class Unit1assembly with _$Unit1assembly {
  const factory Unit1assembly({
    required String pufU1Id,
    required String message,
    required int status,
  }) = _Unit1assembly;

  factory Unit1assembly.fromJson(Map<String, dynamic> json) => _$Unit1assemblyFromJson(json);
}

@freezed
class Unit1assemblyRequest with _$Unit1assemblyRequest {
  const factory Unit1assemblyRequest({
    required String barcodeScan,
  }) = _Unit1assemblyRequest;

  factory Unit1assemblyRequest.fromJson(Map<String, dynamic> json) => 
      _$Unit1assemblyRequestFromJson(json);
}
