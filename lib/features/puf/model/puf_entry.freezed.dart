// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puf_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PufEntry _$PufEntryFromJson(Map<String, dynamic> json) {
  return _PufEntry.fromJson(json);
}

/// @nodoc
mixin _$PufEntry {
  String get pufU1Id => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PufEntryCopyWith<PufEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PufEntryCopyWith<$Res> {
  factory $PufEntryCopyWith(PufEntry value, $Res Function(PufEntry) then) =
      _$PufEntryCopyWithImpl<$Res, PufEntry>;
  @useResult
  $Res call({String pufU1Id, String message, int status});
}

/// @nodoc
class _$PufEntryCopyWithImpl<$Res, $Val extends PufEntry>
    implements $PufEntryCopyWith<$Res> {
  _$PufEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pufU1Id = null,
    Object? message = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      pufU1Id: null == pufU1Id
          ? _value.pufU1Id
          : pufU1Id // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PufEntryImplCopyWith<$Res>
    implements $PufEntryCopyWith<$Res> {
  factory _$$PufEntryImplCopyWith(
          _$PufEntryImpl value, $Res Function(_$PufEntryImpl) then) =
      __$$PufEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pufU1Id, String message, int status});
}

/// @nodoc
class __$$PufEntryImplCopyWithImpl<$Res>
    extends _$PufEntryCopyWithImpl<$Res, _$PufEntryImpl>
    implements _$$PufEntryImplCopyWith<$Res> {
  __$$PufEntryImplCopyWithImpl(
      _$PufEntryImpl _value, $Res Function(_$PufEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pufU1Id = null,
    Object? message = null,
    Object? status = null,
  }) {
    return _then(_$PufEntryImpl(
      pufU1Id: null == pufU1Id
          ? _value.pufU1Id
          : pufU1Id // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PufEntryImpl implements _PufEntry {
  const _$PufEntryImpl(
      {required this.pufU1Id, required this.message, required this.status});

  factory _$PufEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PufEntryImplFromJson(json);

  @override
  final String pufU1Id;
  @override
  final String message;
  @override
  final int status;

  @override
  String toString() {
    return 'PufEntry(pufU1Id: $pufU1Id, message: $message, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PufEntryImpl &&
            (identical(other.pufU1Id, pufU1Id) || other.pufU1Id == pufU1Id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pufU1Id, message, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PufEntryImplCopyWith<_$PufEntryImpl> get copyWith =>
      __$$PufEntryImplCopyWithImpl<_$PufEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PufEntryImplToJson(
      this,
    );
  }
}

abstract class _PufEntry implements PufEntry {
  const factory _PufEntry(
      {required final String pufU1Id,
      required final String message,
      required final int status}) = _$PufEntryImpl;

  factory _PufEntry.fromJson(Map<String, dynamic> json) =
      _$PufEntryImpl.fromJson;

  @override
  String get pufU1Id;
  @override
  String get message;
  @override
  int get status;
  @override
  @JsonKey(ignore: true)
  _$$PufEntryImplCopyWith<_$PufEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PufEntryRequest _$PufEntryRequestFromJson(Map<String, dynamic> json) {
  return _PufEntryRequest.fromJson(json);
}

/// @nodoc
mixin _$PufEntryRequest {
  String get barcodeScan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PufEntryRequestCopyWith<PufEntryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PufEntryRequestCopyWith<$Res> {
  factory $PufEntryRequestCopyWith(
          PufEntryRequest value, $Res Function(PufEntryRequest) then) =
      _$PufEntryRequestCopyWithImpl<$Res, PufEntryRequest>;
  @useResult
  $Res call({String barcodeScan});
}

/// @nodoc
class _$PufEntryRequestCopyWithImpl<$Res, $Val extends PufEntryRequest>
    implements $PufEntryRequestCopyWith<$Res> {
  _$PufEntryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcodeScan = null,
  }) {
    return _then(_value.copyWith(
      barcodeScan: null == barcodeScan
          ? _value.barcodeScan
          : barcodeScan // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PufEntryRequestImplCopyWith<$Res>
    implements $PufEntryRequestCopyWith<$Res> {
  factory _$$PufEntryRequestImplCopyWith(_$PufEntryRequestImpl value,
          $Res Function(_$PufEntryRequestImpl) then) =
      __$$PufEntryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String barcodeScan});
}

/// @nodoc
class __$$PufEntryRequestImplCopyWithImpl<$Res>
    extends _$PufEntryRequestCopyWithImpl<$Res, _$PufEntryRequestImpl>
    implements _$$PufEntryRequestImplCopyWith<$Res> {
  __$$PufEntryRequestImplCopyWithImpl(
      _$PufEntryRequestImpl _value, $Res Function(_$PufEntryRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcodeScan = null,
  }) {
    return _then(_$PufEntryRequestImpl(
      barcodeScan: null == barcodeScan
          ? _value.barcodeScan
          : barcodeScan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PufEntryRequestImpl implements _PufEntryRequest {
  const _$PufEntryRequestImpl({required this.barcodeScan});

  factory _$PufEntryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PufEntryRequestImplFromJson(json);

  @override
  final String barcodeScan;

  @override
  String toString() {
    return 'PufEntryRequest(barcodeScan: $barcodeScan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PufEntryRequestImpl &&
            (identical(other.barcodeScan, barcodeScan) ||
                other.barcodeScan == barcodeScan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, barcodeScan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PufEntryRequestImplCopyWith<_$PufEntryRequestImpl> get copyWith =>
      __$$PufEntryRequestImplCopyWithImpl<_$PufEntryRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PufEntryRequestImplToJson(
      this,
    );
  }
}

abstract class _PufEntryRequest implements PufEntryRequest {
  const factory _PufEntryRequest({required final String barcodeScan}) =
      _$PufEntryRequestImpl;

  factory _PufEntryRequest.fromJson(Map<String, dynamic> json) =
      _$PufEntryRequestImpl.fromJson;

  @override
  String get barcodeScan;
  @override
  @JsonKey(ignore: true)
  _$$PufEntryRequestImplCopyWith<_$PufEntryRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
