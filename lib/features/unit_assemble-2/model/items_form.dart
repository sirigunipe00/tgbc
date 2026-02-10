import 'package:freezed_annotation/freezed_annotation.dart';

part 'items_form.freezed.dart';
part 'items_form.g.dart';

@freezed
class ItemsForm with _$ItemsForm {
  const factory ItemsForm({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'owner') String? owner,
    @JsonKey(name: 'creation') String? creation,
    @JsonKey(name: 'docstatus') int? docstatus,
    @JsonKey(name: 'item') String? item,
    @JsonKey(name: 'is_photo_mandatory') int? isphotomandatory,
    @JsonKey(name: 'item_name') String? itemname,
    @JsonKey(name: 'parent') String? parent,
    @JsonKey(name: 'parentfield') String? parentfield,
    @JsonKey(name: 'parenttype') String? parenttype,
    @JsonKey(name: 'doctype') String? doctype,
  }) = _ItemsForm;

  factory ItemsForm.fromJson(Map<String, Object?> json) =>
      _$ItemsFormFromJson(json);
}
