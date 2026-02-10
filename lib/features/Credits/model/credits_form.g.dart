// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditsFormImpl _$$CreditsFormImplFromJson(Map<String, dynamic> json) =>
    _$CreditsFormImpl(
      name: json['name'] as String?,
      creation: json['creation'] as String? ?? '',
      docstatus: (json['docstatus'] as num?)?.toInt(),
      invoiceDate: json['invoice_date'] as String? ?? '',
      barcodescan: json['barcode_scan'] as String?,
      scanVal: json['scan_value'] as String?,
      serialno: json['serial_no'] as String?,
      isPhotoMandatory: (json['is_photo_mandotary'] as num?)?.toInt() ?? 0,
      item: json['item'] as String?,
      uom: json['uom'] as String?,
      productionplan: json['production_plan'] as String?,
      workorder: json['work_order'] as String?,
      pufdate: json['puf_date'] as String?,
      differenceinseconds: (json['difference_in_seconds'] as num?)?.toDouble(),
      bom: json['bom'] as String?,
      itemName: json['item_name'] as String?,
      description: json['description'] as String?,
      photo: json['photo'] as String?,
      items: (json['component_scanning_puf'] as List<dynamic>?)
              ?.map((e) => ItemsForm.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$CreditsFormImplToJson(_$CreditsFormImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'creation': instance.creation,
      'docstatus': instance.docstatus,
      'invoice_date': instance.invoiceDate,
      'barcode_scan': instance.barcodescan,
      'scan_value': instance.scanVal,
      'serial_no': instance.serialno,
      'is_photo_mandotary': instance.isPhotoMandatory,
      'item': instance.item,
      'uom': instance.uom,
      'production_plan': instance.productionplan,
      'work_order': instance.workorder,
      'puf_date': instance.pufdate,
      'difference_in_seconds': instance.differenceinseconds,
      'bom': instance.bom,
      'item_name': instance.itemName,
      'description': instance.description,
      'photo': instance.photo,
      'component_scanning_puf': instance.items,
    };
