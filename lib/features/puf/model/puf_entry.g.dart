// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puf_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PufEntryImpl _$$PufEntryImplFromJson(Map<String, dynamic> json) =>
    _$PufEntryImpl(
      pufU1Id: json['pufU1Id'] as String,
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$$PufEntryImplToJson(_$PufEntryImpl instance) =>
    <String, dynamic>{
      'pufU1Id': instance.pufU1Id,
      'message': instance.message,
      'status': instance.status,
    };

_$PufEntryRequestImpl _$$PufEntryRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PufEntryRequestImpl(
      barcodeScan: json['barcodeScan'] as String,
    );

Map<String, dynamic> _$$PufEntryRequestImplToJson(
        _$PufEntryRequestImpl instance) =>
    <String, dynamic>{
      'barcodeScan': instance.barcodeScan,
    };
