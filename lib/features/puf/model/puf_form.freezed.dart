// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puf_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PufForm _$PufFormFromJson(Map<String, dynamic> json) {
  return _PufForm.fromJson(json);
}

/// @nodoc
mixin _$PufForm {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'creation', defaultValue: '')
  String? get creation => throw _privateConstructorUsedError;
  @JsonKey(name: 'docstatus')
  int? get docstatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_date', defaultValue: '')
  String get invoiceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'barcode_scan')
  String? get barcodescan => throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_value_barcode')
  String? get scanVal => throw _privateConstructorUsedError;
  @JsonKey(name: 'serial_no')
  String? get serialno => throw _privateConstructorUsedError;
  @JsonKey(
      includeFromJson: false,
      includeToJson: false,
      fromJson: toNull,
      toJson: toNull)
  File? get attachment => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
  int? get isPhotoMandatory => throw _privateConstructorUsedError;
  @JsonKey(name: 'item')
  String? get item => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo')
  String? get photo => throw _privateConstructorUsedError;
  @JsonKey(name: 'uom')
  String? get uom => throw _privateConstructorUsedError;
  @JsonKey(name: 'production_plan')
  String? get productionplan => throw _privateConstructorUsedError;
  @JsonKey(name: 'work_order')
  String? get workorder => throw _privateConstructorUsedError;
  @JsonKey(name: 'puf_date')
  String? get pufdate => throw _privateConstructorUsedError;
  @JsonKey(name: 'difference_in_seconds')
  double? get differenceinseconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'bom')
  String? get bom => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_name')
  String? get itemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'component_scanning_puf', defaultValue: [])
  List<ItemsForm> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PufFormCopyWith<PufForm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PufFormCopyWith<$Res> {
  factory $PufFormCopyWith(PufForm value, $Res Function(PufForm) then) =
      _$PufFormCopyWithImpl<$Res, PufForm>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'creation', defaultValue: '') String? creation,
      @JsonKey(name: 'docstatus') int? docstatus,
      @JsonKey(name: 'invoice_date', defaultValue: '') String invoiceDate,
      @JsonKey(name: 'barcode_scan') String? barcodescan,
      @JsonKey(name: 'scan_value_barcode') String? scanVal,
      @JsonKey(name: 'serial_no') String? serialno,
      @JsonKey(
          includeFromJson: false,
          includeToJson: false,
          fromJson: toNull,
          toJson: toNull)
      File? attachment,
      @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
      int? isPhotoMandatory,
      @JsonKey(name: 'item') String? item,
      @JsonKey(name: 'photo') String? photo,
      @JsonKey(name: 'uom') String? uom,
      @JsonKey(name: 'production_plan') String? productionplan,
      @JsonKey(name: 'work_order') String? workorder,
      @JsonKey(name: 'puf_date') String? pufdate,
      @JsonKey(name: 'difference_in_seconds') double? differenceinseconds,
      @JsonKey(name: 'bom') String? bom,
      @JsonKey(name: 'item_name') String? itemName,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'component_scanning_puf', defaultValue: [])
      List<ItemsForm> items});
}

/// @nodoc
class _$PufFormCopyWithImpl<$Res, $Val extends PufForm>
    implements $PufFormCopyWith<$Res> {
  _$PufFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? creation = freezed,
    Object? docstatus = freezed,
    Object? invoiceDate = null,
    Object? barcodescan = freezed,
    Object? scanVal = freezed,
    Object? serialno = freezed,
    Object? attachment = freezed,
    Object? isPhotoMandatory = freezed,
    Object? item = freezed,
    Object? photo = freezed,
    Object? uom = freezed,
    Object? productionplan = freezed,
    Object? workorder = freezed,
    Object? pufdate = freezed,
    Object? differenceinseconds = freezed,
    Object? bom = freezed,
    Object? itemName = freezed,
    Object? description = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as String?,
      docstatus: freezed == docstatus
          ? _value.docstatus
          : docstatus // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String,
      barcodescan: freezed == barcodescan
          ? _value.barcodescan
          : barcodescan // ignore: cast_nullable_to_non_nullable
              as String?,
      scanVal: freezed == scanVal
          ? _value.scanVal
          : scanVal // ignore: cast_nullable_to_non_nullable
              as String?,
      serialno: freezed == serialno
          ? _value.serialno
          : serialno // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as File?,
      isPhotoMandatory: freezed == isPhotoMandatory
          ? _value.isPhotoMandatory
          : isPhotoMandatory // ignore: cast_nullable_to_non_nullable
              as int?,
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      productionplan: freezed == productionplan
          ? _value.productionplan
          : productionplan // ignore: cast_nullable_to_non_nullable
              as String?,
      workorder: freezed == workorder
          ? _value.workorder
          : workorder // ignore: cast_nullable_to_non_nullable
              as String?,
      pufdate: freezed == pufdate
          ? _value.pufdate
          : pufdate // ignore: cast_nullable_to_non_nullable
              as String?,
      differenceinseconds: freezed == differenceinseconds
          ? _value.differenceinseconds
          : differenceinseconds // ignore: cast_nullable_to_non_nullable
              as double?,
      bom: freezed == bom
          ? _value.bom
          : bom // ignore: cast_nullable_to_non_nullable
              as String?,
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemsForm>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PufFormImplCopyWith<$Res> implements $PufFormCopyWith<$Res> {
  factory _$$PufFormImplCopyWith(
          _$PufFormImpl value, $Res Function(_$PufFormImpl) then) =
      __$$PufFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: 'creation', defaultValue: '') String? creation,
      @JsonKey(name: 'docstatus') int? docstatus,
      @JsonKey(name: 'invoice_date', defaultValue: '') String invoiceDate,
      @JsonKey(name: 'barcode_scan') String? barcodescan,
      @JsonKey(name: 'scan_value_barcode') String? scanVal,
      @JsonKey(name: 'serial_no') String? serialno,
      @JsonKey(
          includeFromJson: false,
          includeToJson: false,
          fromJson: toNull,
          toJson: toNull)
      File? attachment,
      @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
      int? isPhotoMandatory,
      @JsonKey(name: 'item') String? item,
      @JsonKey(name: 'photo') String? photo,
      @JsonKey(name: 'uom') String? uom,
      @JsonKey(name: 'production_plan') String? productionplan,
      @JsonKey(name: 'work_order') String? workorder,
      @JsonKey(name: 'puf_date') String? pufdate,
      @JsonKey(name: 'difference_in_seconds') double? differenceinseconds,
      @JsonKey(name: 'bom') String? bom,
      @JsonKey(name: 'item_name') String? itemName,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'component_scanning_puf', defaultValue: [])
      List<ItemsForm> items});
}

/// @nodoc
class __$$PufFormImplCopyWithImpl<$Res>
    extends _$PufFormCopyWithImpl<$Res, _$PufFormImpl>
    implements _$$PufFormImplCopyWith<$Res> {
  __$$PufFormImplCopyWithImpl(
      _$PufFormImpl _value, $Res Function(_$PufFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? creation = freezed,
    Object? docstatus = freezed,
    Object? invoiceDate = null,
    Object? barcodescan = freezed,
    Object? scanVal = freezed,
    Object? serialno = freezed,
    Object? attachment = freezed,
    Object? isPhotoMandatory = freezed,
    Object? item = freezed,
    Object? photo = freezed,
    Object? uom = freezed,
    Object? productionplan = freezed,
    Object? workorder = freezed,
    Object? pufdate = freezed,
    Object? differenceinseconds = freezed,
    Object? bom = freezed,
    Object? itemName = freezed,
    Object? description = freezed,
    Object? items = null,
  }) {
    return _then(_$PufFormImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as String?,
      docstatus: freezed == docstatus
          ? _value.docstatus
          : docstatus // ignore: cast_nullable_to_non_nullable
              as int?,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String,
      barcodescan: freezed == barcodescan
          ? _value.barcodescan
          : barcodescan // ignore: cast_nullable_to_non_nullable
              as String?,
      scanVal: freezed == scanVal
          ? _value.scanVal
          : scanVal // ignore: cast_nullable_to_non_nullable
              as String?,
      serialno: freezed == serialno
          ? _value.serialno
          : serialno // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as File?,
      isPhotoMandatory: freezed == isPhotoMandatory
          ? _value.isPhotoMandatory
          : isPhotoMandatory // ignore: cast_nullable_to_non_nullable
              as int?,
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      uom: freezed == uom
          ? _value.uom
          : uom // ignore: cast_nullable_to_non_nullable
              as String?,
      productionplan: freezed == productionplan
          ? _value.productionplan
          : productionplan // ignore: cast_nullable_to_non_nullable
              as String?,
      workorder: freezed == workorder
          ? _value.workorder
          : workorder // ignore: cast_nullable_to_non_nullable
              as String?,
      pufdate: freezed == pufdate
          ? _value.pufdate
          : pufdate // ignore: cast_nullable_to_non_nullable
              as String?,
      differenceinseconds: freezed == differenceinseconds
          ? _value.differenceinseconds
          : differenceinseconds // ignore: cast_nullable_to_non_nullable
              as double?,
      bom: freezed == bom
          ? _value.bom
          : bom // ignore: cast_nullable_to_non_nullable
              as String?,
      itemName: freezed == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemsForm>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PufFormImpl implements _PufForm {
  const _$PufFormImpl(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: 'creation', defaultValue: '') this.creation,
      @JsonKey(name: 'docstatus') this.docstatus,
      @JsonKey(name: 'invoice_date', defaultValue: '')
      required this.invoiceDate,
      @JsonKey(name: 'barcode_scan') this.barcodescan,
      @JsonKey(name: 'scan_value_barcode') this.scanVal,
      @JsonKey(name: 'serial_no') this.serialno,
      @JsonKey(
          includeFromJson: false,
          includeToJson: false,
          fromJson: toNull,
          toJson: toNull)
      this.attachment,
      @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
      this.isPhotoMandatory,
      @JsonKey(name: 'item') this.item,
      @JsonKey(name: 'photo') this.photo,
      @JsonKey(name: 'uom') this.uom,
      @JsonKey(name: 'production_plan') this.productionplan,
      @JsonKey(name: 'work_order') this.workorder,
      @JsonKey(name: 'puf_date') this.pufdate,
      @JsonKey(name: 'difference_in_seconds') this.differenceinseconds,
      @JsonKey(name: 'bom') this.bom,
      @JsonKey(name: 'item_name') this.itemName,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'component_scanning_puf', defaultValue: [])
      required final List<ItemsForm> items})
      : _items = items;

  factory _$PufFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$PufFormImplFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'creation', defaultValue: '')
  final String? creation;
  @override
  @JsonKey(name: 'docstatus')
  final int? docstatus;
  @override
  @JsonKey(name: 'invoice_date', defaultValue: '')
  final String invoiceDate;
  @override
  @JsonKey(name: 'barcode_scan')
  final String? barcodescan;
  @override
  @JsonKey(name: 'scan_value_barcode')
  final String? scanVal;
  @override
  @JsonKey(name: 'serial_no')
  final String? serialno;
  @override
  @JsonKey(
      includeFromJson: false,
      includeToJson: false,
      fromJson: toNull,
      toJson: toNull)
  final File? attachment;
  @override
  @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
  final int? isPhotoMandatory;
  @override
  @JsonKey(name: 'item')
  final String? item;
  @override
  @JsonKey(name: 'photo')
  final String? photo;
  @override
  @JsonKey(name: 'uom')
  final String? uom;
  @override
  @JsonKey(name: 'production_plan')
  final String? productionplan;
  @override
  @JsonKey(name: 'work_order')
  final String? workorder;
  @override
  @JsonKey(name: 'puf_date')
  final String? pufdate;
  @override
  @JsonKey(name: 'difference_in_seconds')
  final double? differenceinseconds;
  @override
  @JsonKey(name: 'bom')
  final String? bom;
  @override
  @JsonKey(name: 'item_name')
  final String? itemName;
  @override
  @JsonKey(name: 'description')
  final String? description;
  final List<ItemsForm> _items;
  @override
  @JsonKey(name: 'component_scanning_puf', defaultValue: [])
  List<ItemsForm> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PufForm(name: $name, creation: $creation, docstatus: $docstatus, invoiceDate: $invoiceDate, barcodescan: $barcodescan, scanVal: $scanVal, serialno: $serialno, attachment: $attachment, isPhotoMandatory: $isPhotoMandatory, item: $item, photo: $photo, uom: $uom, productionplan: $productionplan, workorder: $workorder, pufdate: $pufdate, differenceinseconds: $differenceinseconds, bom: $bom, itemName: $itemName, description: $description, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PufFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.creation, creation) ||
                other.creation == creation) &&
            (identical(other.docstatus, docstatus) ||
                other.docstatus == docstatus) &&
            (identical(other.invoiceDate, invoiceDate) ||
                other.invoiceDate == invoiceDate) &&
            (identical(other.barcodescan, barcodescan) ||
                other.barcodescan == barcodescan) &&
            (identical(other.scanVal, scanVal) || other.scanVal == scanVal) &&
            (identical(other.serialno, serialno) ||
                other.serialno == serialno) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment) &&
            (identical(other.isPhotoMandatory, isPhotoMandatory) ||
                other.isPhotoMandatory == isPhotoMandatory) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.uom, uom) || other.uom == uom) &&
            (identical(other.productionplan, productionplan) ||
                other.productionplan == productionplan) &&
            (identical(other.workorder, workorder) ||
                other.workorder == workorder) &&
            (identical(other.pufdate, pufdate) || other.pufdate == pufdate) &&
            (identical(other.differenceinseconds, differenceinseconds) ||
                other.differenceinseconds == differenceinseconds) &&
            (identical(other.bom, bom) || other.bom == bom) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        creation,
        docstatus,
        invoiceDate,
        barcodescan,
        scanVal,
        serialno,
        attachment,
        isPhotoMandatory,
        item,
        photo,
        uom,
        productionplan,
        workorder,
        pufdate,
        differenceinseconds,
        bom,
        itemName,
        description,
        const DeepCollectionEquality().hash(_items)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PufFormImplCopyWith<_$PufFormImpl> get copyWith =>
      __$$PufFormImplCopyWithImpl<_$PufFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PufFormImplToJson(
      this,
    );
  }
}

abstract class _PufForm implements PufForm {
  const factory _PufForm(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'creation', defaultValue: '') final String? creation,
      @JsonKey(name: 'docstatus') final int? docstatus,
      @JsonKey(name: 'invoice_date', defaultValue: '')
      required final String invoiceDate,
      @JsonKey(name: 'barcode_scan') final String? barcodescan,
      @JsonKey(name: 'scan_value_barcode') final String? scanVal,
      @JsonKey(name: 'serial_no') final String? serialno,
      @JsonKey(
          includeFromJson: false,
          includeToJson: false,
          fromJson: toNull,
          toJson: toNull)
      final File? attachment,
      @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
      final int? isPhotoMandatory,
      @JsonKey(name: 'item') final String? item,
      @JsonKey(name: 'photo') final String? photo,
      @JsonKey(name: 'uom') final String? uom,
      @JsonKey(name: 'production_plan') final String? productionplan,
      @JsonKey(name: 'work_order') final String? workorder,
      @JsonKey(name: 'puf_date') final String? pufdate,
      @JsonKey(name: 'difference_in_seconds') final double? differenceinseconds,
      @JsonKey(name: 'bom') final String? bom,
      @JsonKey(name: 'item_name') final String? itemName,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'component_scanning_puf', defaultValue: [])
      required final List<ItemsForm> items}) = _$PufFormImpl;

  factory _PufForm.fromJson(Map<String, dynamic> json) = _$PufFormImpl.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'creation', defaultValue: '')
  String? get creation;
  @override
  @JsonKey(name: 'docstatus')
  int? get docstatus;
  @override
  @JsonKey(name: 'invoice_date', defaultValue: '')
  String get invoiceDate;
  @override
  @JsonKey(name: 'barcode_scan')
  String? get barcodescan;
  @override
  @JsonKey(name: 'scan_value_barcode')
  String? get scanVal;
  @override
  @JsonKey(name: 'serial_no')
  String? get serialno;
  @override
  @JsonKey(
      includeFromJson: false,
      includeToJson: false,
      fromJson: toNull,
      toJson: toNull)
  File? get attachment;
  @override
  @JsonKey(name: 'is_photo_mandotary', defaultValue: 0)
  int? get isPhotoMandatory;
  @override
  @JsonKey(name: 'item')
  String? get item;
  @override
  @JsonKey(name: 'photo')
  String? get photo;
  @override
  @JsonKey(name: 'uom')
  String? get uom;
  @override
  @JsonKey(name: 'production_plan')
  String? get productionplan;
  @override
  @JsonKey(name: 'work_order')
  String? get workorder;
  @override
  @JsonKey(name: 'puf_date')
  String? get pufdate;
  @override
  @JsonKey(name: 'difference_in_seconds')
  double? get differenceinseconds;
  @override
  @JsonKey(name: 'bom')
  String? get bom;
  @override
  @JsonKey(name: 'item_name')
  String? get itemName;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'component_scanning_puf', defaultValue: [])
  List<ItemsForm> get items;
  @override
  @JsonKey(ignore: true)
  _$$PufFormImplCopyWith<_$PufFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
