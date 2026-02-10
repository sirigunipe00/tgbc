// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_gate_entry_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewGateEntryFormImpl _$$NewGateEntryFormImplFromJson(
        Map<String, dynamic> json) =>
    _$NewGateEntryFormImpl(
      status: json['status'] as String?,
      name: json['name'] as String?,
      poNumber: json['po_number'] as String?,
      vehicleNo: json['vehicle_no'] as String?,
      vendorInvNo: json['vendor_invoice_no'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      invoiceQty: json['invoice_qty'] as String?,
      invoiceAmt: json['invoice_amount'] as String?,
      entryDate: json['entry_date'] as String,
      vehiclePhoto: json['vehicle_photo'] as String?,
      vehicleBackPhoto: json['vehicle_back_photo'] as String?,
      vendorInvPhoto: json['invoice_photo'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$$NewGateEntryFormImplToJson(
    _$NewGateEntryFormImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['po_number'] = instance.poNumber;
  val['vehicle_no'] = instance.vehicleNo;
  val['vendor_invoice_no'] = instance.vendorInvNo;
  val['invoice_date'] = instance.invoiceDate;
  val['invoice_qty'] = instance.invoiceQty;
  val['invoice_amount'] = instance.invoiceAmt;
  val['entry_date'] = instance.entryDate;
  val['vehicle_photo'] = instance.vehiclePhoto;
  val['vehicle_back_photo'] = instance.vehicleBackPhoto;
  val['invoice_photo'] = instance.vendorInvPhoto;
  val['remarks'] = instance.remarks;
  return val;
}
