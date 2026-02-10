// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit1_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Unit1assembly _$Unit1assemblyFromJson(Map<String, dynamic> json) {
  return _Unit1assembly.fromJson(json);
}

/// @nodoc
mixin _$Unit1assembly {
  String get pufU1Id => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Unit1assemblyCopyWith<Unit1assembly> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Unit1assemblyCopyWith<$Res> {
  factory $Unit1assemblyCopyWith(
          Unit1assembly value, $Res Function(Unit1assembly) then) =
      _$Unit1assemblyCopyWithImpl<$Res, Unit1assembly>;
  @useResult
  $Res call({String pufU1Id, String message, int status});
}

/// @nodoc
class _$Unit1assemblyCopyWithImpl<$Res, $Val extends Unit1assembly>
    implements $Unit1assemblyCopyWith<$Res> {
  _$Unit1assemblyCopyWithImpl(this._value, this._then);

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
abstract class _$$Unit1assemblyImplCopyWith<$Res>
    implements $Unit1assemblyCopyWith<$Res> {
  factory _$$Unit1assemblyImplCopyWith(
          _$Unit1assemblyImpl value, $Res Function(_$Unit1assemblyImpl) then) =
      __$$Unit1assemblyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pufU1Id, String message, int status});
}

/// @nodoc
class __$$Unit1assemblyImplCopyWithImpl<$Res>
    extends _$Unit1assemblyCopyWithImpl<$Res, _$Unit1assemblyImpl>
    implements _$$Unit1assemblyImplCopyWith<$Res> {
  __$$Unit1assemblyImplCopyWithImpl(
      _$Unit1assemblyImpl _value, $Res Function(_$Unit1assemblyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pufU1Id = null,
    Object? message = null,
    Object? status = null,
  }) {
    return _then(_$Unit1assemblyImpl(
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
class _$Unit1assemblyImpl implements _Unit1assembly {
  const _$Unit1assemblyImpl(
      {required this.pufU1Id, required this.message, required this.status});

  factory _$Unit1assemblyImpl.fromJson(Map<String, dynamic> json) =>
      _$$Unit1assemblyImplFromJson(json);

  @override
  final String pufU1Id;
  @override
  final String message;
  @override
  final int status;

  @override
  String toString() {
    return 'Unit1assembly(pufU1Id: $pufU1Id, message: $message, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Unit1assemblyImpl &&
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
  _$$Unit1assemblyImplCopyWith<_$Unit1assemblyImpl> get copyWith =>
      __$$Unit1assemblyImplCopyWithImpl<_$Unit1assemblyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Unit1assemblyImplToJson(
      this,
    );
  }
}

abstract class _Unit1assembly implements Unit1assembly {
  const factory _Unit1assembly(
      {required final String pufU1Id,
      required final String message,
      required final int status}) = _$Unit1assemblyImpl;

  factory _Unit1assembly.fromJson(Map<String, dynamic> json) =
      _$Unit1assemblyImpl.fromJson;

  @override
  String get pufU1Id;
  @override
  String get message;
  @override
  int get status;
  @override
  @JsonKey(ignore: true)
  _$$Unit1assemblyImplCopyWith<_$Unit1assemblyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Unit1assemblyRequest _$Unit1assemblyRequestFromJson(Map<String, dynamic> json) {
  return _Unit1assemblyRequest.fromJson(json);
}

/// @nodoc
mixin _$Unit1assemblyRequest {
  String get barcodeScan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Unit1assemblyRequestCopyWith<Unit1assemblyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Unit1assemblyRequestCopyWith<$Res> {
  factory $Unit1assemblyRequestCopyWith(Unit1assemblyRequest value,
          $Res Function(Unit1assemblyRequest) then) =
      _$Unit1assemblyRequestCopyWithImpl<$Res, Unit1assemblyRequest>;
  @useResult
  $Res call({String barcodeScan});
}

/// @nodoc
class _$Unit1assemblyRequestCopyWithImpl<$Res,
        $Val extends Unit1assemblyRequest>
    implements $Unit1assemblyRequestCopyWith<$Res> {
  _$Unit1assemblyRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$Unit1assemblyRequestImplCopyWith<$Res>
    implements $Unit1assemblyRequestCopyWith<$Res> {
  factory _$$Unit1assemblyRequestImplCopyWith(_$Unit1assemblyRequestImpl value,
          $Res Function(_$Unit1assemblyRequestImpl) then) =
      __$$Unit1assemblyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String barcodeScan});
}

/// @nodoc
class __$$Unit1assemblyRequestImplCopyWithImpl<$Res>
    extends _$Unit1assemblyRequestCopyWithImpl<$Res, _$Unit1assemblyRequestImpl>
    implements _$$Unit1assemblyRequestImplCopyWith<$Res> {
  __$$Unit1assemblyRequestImplCopyWithImpl(_$Unit1assemblyRequestImpl _value,
      $Res Function(_$Unit1assemblyRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcodeScan = null,
  }) {
    return _then(_$Unit1assemblyRequestImpl(
      barcodeScan: null == barcodeScan
          ? _value.barcodeScan
          : barcodeScan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Unit1assemblyRequestImpl implements _Unit1assemblyRequest {
  const _$Unit1assemblyRequestImpl({required this.barcodeScan});

  factory _$Unit1assemblyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$Unit1assemblyRequestImplFromJson(json);

  @override
  final String barcodeScan;

  @override
  String toString() {
    return 'Unit1assemblyRequest(barcodeScan: $barcodeScan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Unit1assemblyRequestImpl &&
            (identical(other.barcodeScan, barcodeScan) ||
                other.barcodeScan == barcodeScan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, barcodeScan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Unit1assemblyRequestImplCopyWith<_$Unit1assemblyRequestImpl>
      get copyWith =>
          __$$Unit1assemblyRequestImplCopyWithImpl<_$Unit1assemblyRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Unit1assemblyRequestImplToJson(
      this,
    );
  }
}

abstract class _Unit1assemblyRequest implements Unit1assemblyRequest {
  const factory _Unit1assemblyRequest({required final String barcodeScan}) =
      _$Unit1assemblyRequestImpl;

  factory _Unit1assemblyRequest.fromJson(Map<String, dynamic> json) =
      _$Unit1assemblyRequestImpl.fromJson;

  @override
  String get barcodeScan;
  @override
  @JsonKey(ignore: true)
  _$$Unit1assemblyRequestImplCopyWith<_$Unit1assemblyRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
