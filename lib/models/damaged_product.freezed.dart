// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'damaged_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DamagedProduct _$DamagedProductFromJson(Map<String, dynamic> json) {
  return _DamagedProduct.fromJson(json);
}

/// @nodoc
mixin _$DamagedProduct {
  String get damagedProductId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get reportedAt => throw _privateConstructorUsedError;

  /// Serializes this DamagedProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DamagedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DamagedProductCopyWith<DamagedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DamagedProductCopyWith<$Res> {
  factory $DamagedProductCopyWith(
          DamagedProduct value, $Res Function(DamagedProduct) then) =
      _$DamagedProductCopyWithImpl<$Res, DamagedProduct>;
  @useResult
  $Res call(
      {String damagedProductId,
      String productName,
      int quantity,
      String reason,
      DateTime reportedAt});
}

/// @nodoc
class _$DamagedProductCopyWithImpl<$Res, $Val extends DamagedProduct>
    implements $DamagedProductCopyWith<$Res> {
  _$DamagedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DamagedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damagedProductId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? reason = null,
    Object? reportedAt = null,
  }) {
    return _then(_value.copyWith(
      damagedProductId: null == damagedProductId
          ? _value.damagedProductId
          : damagedProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DamagedProductImplCopyWith<$Res>
    implements $DamagedProductCopyWith<$Res> {
  factory _$$DamagedProductImplCopyWith(_$DamagedProductImpl value,
          $Res Function(_$DamagedProductImpl) then) =
      __$$DamagedProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String damagedProductId,
      String productName,
      int quantity,
      String reason,
      DateTime reportedAt});
}

/// @nodoc
class __$$DamagedProductImplCopyWithImpl<$Res>
    extends _$DamagedProductCopyWithImpl<$Res, _$DamagedProductImpl>
    implements _$$DamagedProductImplCopyWith<$Res> {
  __$$DamagedProductImplCopyWithImpl(
      _$DamagedProductImpl _value, $Res Function(_$DamagedProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of DamagedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? damagedProductId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? reason = null,
    Object? reportedAt = null,
  }) {
    return _then(_$DamagedProductImpl(
      damagedProductId: null == damagedProductId
          ? _value.damagedProductId
          : damagedProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DamagedProductImpl implements _DamagedProduct {
  const _$DamagedProductImpl(
      {required this.damagedProductId,
      required this.productName,
      required this.quantity,
      required this.reason,
      required this.reportedAt});

  factory _$DamagedProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$DamagedProductImplFromJson(json);

  @override
  final String damagedProductId;
  @override
  final String productName;
  @override
  final int quantity;
  @override
  final String reason;
  @override
  final DateTime reportedAt;

  @override
  String toString() {
    return 'DamagedProduct(damagedProductId: $damagedProductId, productName: $productName, quantity: $quantity, reason: $reason, reportedAt: $reportedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DamagedProductImpl &&
            (identical(other.damagedProductId, damagedProductId) ||
                other.damagedProductId == damagedProductId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, damagedProductId, productName, quantity, reason, reportedAt);

  /// Create a copy of DamagedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DamagedProductImplCopyWith<_$DamagedProductImpl> get copyWith =>
      __$$DamagedProductImplCopyWithImpl<_$DamagedProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DamagedProductImplToJson(
      this,
    );
  }
}

abstract class _DamagedProduct implements DamagedProduct {
  const factory _DamagedProduct(
      {required final String damagedProductId,
      required final String productName,
      required final int quantity,
      required final String reason,
      required final DateTime reportedAt}) = _$DamagedProductImpl;

  factory _DamagedProduct.fromJson(Map<String, dynamic> json) =
      _$DamagedProductImpl.fromJson;

  @override
  String get damagedProductId;
  @override
  String get productName;
  @override
  int get quantity;
  @override
  String get reason;
  @override
  DateTime get reportedAt;

  /// Create a copy of DamagedProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DamagedProductImplCopyWith<_$DamagedProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
