// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GateEntryImpl _$$GateEntryImplFromJson(Map<String, dynamic> json) =>
    _$GateEntryImpl(
      name: json['name'] as String,
      status: json['status'] as String?,
      poNumber: json['po_number'] as String,
      vehicleNo: json['vehicle_no'] as String? ?? '',
      vendorInvNo: json['vendor_invoice_no'] as String? ?? '',
      invoiceDate: json['invoice_date'] as String? ?? '',
      invoiceQty: (json['vendor_invoice_quantity'] as num?)?.toDouble(),
      invoiceAmt: (json['invoice_amount'] as num?)?.toDouble(),
      entryDate: json['gate_entry_date'] as String? ?? '',
      vehiclePhoto: json['vehicle_image'] as String?,
      invoicePhoto: json['vendor_invoice_photo'] as String?,
      vehicleBackPhoto: json['vehicle_back_photo'] as String?,
      remarks: json['remarks'] as String?,
      supplierName: json['supplierName'] as String?,
    );

Map<String, dynamic> _$$GateEntryImplToJson(_$GateEntryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'po_number': instance.poNumber,
      'vehicle_no': instance.vehicleNo,
      'vendor_invoice_no': instance.vendorInvNo,
      'invoice_date': instance.invoiceDate,
      'vendor_invoice_quantity': instance.invoiceQty,
      'invoice_amount': instance.invoiceAmt,
      'gate_entry_date': instance.entryDate,
      'vehicle_image': instance.vehiclePhoto,
      'vendor_invoice_photo': instance.invoicePhoto,
      'vehicle_back_photo': instance.vehicleBackPhoto,
      'remarks': instance.remarks,
      'supplierName': instance.supplierName,
    };
