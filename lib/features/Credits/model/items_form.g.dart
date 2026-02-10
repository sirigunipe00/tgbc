// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemsFormImpl _$$ItemsFormImplFromJson(Map<String, dynamic> json) =>
    _$ItemsFormImpl(
      name: json['name'] as String?,
      owner: json['owner'] as String?,
      creation: json['creation'] as String?,
      docstatus: (json['docstatus'] as num?)?.toInt(),
      item: json['item'] as String?,
      isphotomandatory: (json['is_photo_mandatory'] as num?)?.toInt(),
      itemname: json['item_name'] as String?,
      parent: json['parent'] as String?,
      parentfield: json['parentfield'] as String?,
      parenttype: json['parenttype'] as String?,
      doctype: json['doctype'] as String?,
    );

Map<String, dynamic> _$$ItemsFormImplToJson(_$ItemsFormImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
      'creation': instance.creation,
      'docstatus': instance.docstatus,
      'item': instance.item,
      'is_photo_mandatory': instance.isphotomandatory,
      'item_name': instance.itemname,
      'parent': instance.parent,
      'parentfield': instance.parentfield,
      'parenttype': instance.parenttype,
      'doctype': instance.doctype,
    };
