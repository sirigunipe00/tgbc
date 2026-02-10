// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrt_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VrtFormImpl _$$VrtFormImplFromJson(Map<String, dynamic> json) =>
    _$VrtFormImpl(
      name: json['name'] as String?,
      status: json['status'] as String?,
      documentDate: json['document_date'] as String?,
      docstatus: (json['docstatus'] as num?)?.toInt(),
      transporterDetails: json['transporter_details'] as String? ?? '',
      driverName: json['driver_name'] as String? ?? '',
      driverNumber: json['driver_number'] as String? ?? '',
      tokeStatus: json['token_status'] as String?,
      vehicleNo: json['vehicle_no'] as String?,
      vehicleType: json['vehicle_type'] as String? ?? '',
      rejectReason: json['reject_reason'] as String? ?? '',
    );

Map<String, dynamic> _$$VrtFormImplToJson(_$VrtFormImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'document_date': instance.documentDate,
      'docstatus': instance.docstatus,
      'transporter_details': instance.transporterDetails,
      'driver_name': instance.driverName,
      'driver_number': instance.driverNumber,
      'token_status': instance.tokeStatus,
      'vehicle_no': instance.vehicleNo,
      'vehicle_type': instance.vehicleType,
      'reject_reason': instance.rejectReason,
    };
