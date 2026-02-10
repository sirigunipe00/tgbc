import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order.freezed.dart';
part 'purchase_order.g.dart';

@freezed
class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required String name,
    @JsonKey(name: 'po_number') required String poNumber,
    @JsonKey(name: 'supplier_name') String? supplierName,
    required String date,
    @JsonKey(name: 'total_amount', defaultValue: 0.0) required double totalAmount,
    @JsonKey(name: 'total_qty', defaultValue: 0.0) required double totalQnty,
  }) = _PurchaseOrder;

  factory PurchaseOrder.fromJson(Map<String, Object?> json)
      => _$PurchaseOrderFromJson(json);
}