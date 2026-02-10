// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit1_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Unit1assemblyImpl _$$Unit1assemblyImplFromJson(Map<String, dynamic> json) =>
    _$Unit1assemblyImpl(
      pufU1Id: json['pufU1Id'] as String,
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$$Unit1assemblyImplToJson(_$Unit1assemblyImpl instance) =>
    <String, dynamic>{
      'pufU1Id': instance.pufU1Id,
      'message': instance.message,
      'status': instance.status,
    };

_$Unit1assemblyRequestImpl _$$Unit1assemblyRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$Unit1assemblyRequestImpl(
      barcodeScan: json['barcodeScan'] as String,
    );

Map<String, dynamic> _$$Unit1assemblyRequestImplToJson(
        _$Unit1assemblyRequestImpl instance) =>
    <String, dynamic>{
      'barcodeScan': instance.barcodeScan,
    };
