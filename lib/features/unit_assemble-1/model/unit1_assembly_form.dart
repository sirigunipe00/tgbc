import 'dart:io';

import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/puf/model/items_form.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit1_assembly_form.freezed.dart';
part 'unit1_assembly_form.g.dart';

@freezed
class UnitassemblyForm with _$UnitassemblyForm {
  const factory UnitassemblyForm({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'creation', defaultValue: '') String? creation,
    @JsonKey(name: 'docstatus') int? docstatus,
    @JsonKey(name: 'invoice_date', defaultValue: '')
    required String invoiceDate,
    @JsonKey(name: 'barcode_scan') String? barcodescan,
    @JsonKey(name: 'scan_value') String? scanVal,
    @JsonKey(name: 'serial_no') String? serialno,
    @JsonKey(
        includeFromJson: false,
        includeToJson: false,
        fromJson: toNull,
        toJson: toNull) File? attachment,
    @JsonKey(name: 'is_photo_mandatory') int? isPhotoMandatory,
    @JsonKey(name: 'item') String? item,
    @JsonKey(name: 'uom') String? uom,
    @JsonKey(name: 'production_plan') String? productionplan,
    @JsonKey(name: 'work_order') String? workorder,
    @JsonKey(name: 'puf_date') String? pufdate,
    @JsonKey(name: 'difference_in_seconds') double? differenceinseconds,
    @JsonKey(name: 'bom') String? bom,
    @JsonKey(name: 'item_name') String? itemName,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'photo') String? photo,
    @JsonKey(name: 'component_scanning_puf', defaultValue: [])
    required List<ItemsForm> items,
  }) = _UnitassemblyForm;

  factory UnitassemblyForm.fromJson(Map<String, Object?> json) =>
      _$UnitassemblyFormFromJson(json);
}
