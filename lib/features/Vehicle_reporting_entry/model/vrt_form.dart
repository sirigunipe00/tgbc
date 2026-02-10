// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'vrt_form.freezed.dart';
part 'vrt_form.g.dart';

@freezed
class VrtForm with _$VrtForm {
  const factory VrtForm({
    String? name,
    String? status,
    @JsonKey(name: 'document_date')  String? documentDate,
    @JsonKey(name: 'docstatus') int? docstatus,
    @JsonKey(name: 'transporter_details', defaultValue: '')  String? transporterDetails,
    @JsonKey(name: 'driver_name', defaultValue: '')  String? driverName,
    @JsonKey(name: 'driver_number', defaultValue: '')  String? driverNumber,
    @JsonKey(name: 'token_status') String? tokeStatus,
    @JsonKey(name: 'vehicle_no') String? vehicleNo,
    @JsonKey(name: 'vehicle_type', defaultValue: '')  String? vehicleType,
    @JsonKey(name: 'reject_reason', defaultValue: '')  String? rejectReason,
  }) = _VrtForm;

  factory VrtForm.fromJson(Map<String, Object?> json)
      => _$VrtFormFromJson(json);

      static Map<String, dynamic> toEncodedFormJson(final VrtForm form) {
    final json = form.toJson();

    return json;
  }
}