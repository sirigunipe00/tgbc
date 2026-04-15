// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseOrderImpl _$$PurchaseOrderImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseOrderImpl(
      name: json['name'] as String?,
      poNumber: json['po_number'] as String?,
      supplierName: json['supplier_name'] as String?,
      date: json['date'] as String?,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      totalQnty: (json['total_qty'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$PurchaseOrderImplToJson(_$PurchaseOrderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'po_number': instance.poNumber,
      'supplier_name': instance.supplierName,
      'date': instance.date,
      'total_amount': instance.totalAmount,
      'total_qty': instance.totalQnty,
    };
