// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Delivery _$DeliveryFromJson(Map<String, dynamic> json) {
  return _Delivery.fromJson(json);
}

/// @nodoc
mixin _$Delivery {
  String get deliveryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get licenseNumber => throw _privateConstructorUsedError;
  String get contactInfo => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get productType =>
      throw _privateConstructorUsedError; // Added field for type of product
  int get productQuantity => throw _privateConstructorUsedError;

  /// Serializes this Delivery to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliveryCopyWith<Delivery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliveryCopyWith<$Res> {
  factory $DeliveryCopyWith(Delivery value, $Res Function(Delivery) then) =
      _$DeliveryCopyWithImpl<$Res, Delivery>;
  @useResult
  $Res call(
      {String deliveryId,
      String name,
      String licenseNumber,
      String contactInfo,
      String status,
      DateTime createdAt,
      String productType,
      int productQuantity});
}

/// @nodoc
class _$DeliveryCopyWithImpl<$Res, $Val extends Delivery>
    implements $DeliveryCopyWith<$Res> {
  _$DeliveryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryId = null,
    Object? name = null,
    Object? licenseNumber = null,
    Object? contactInfo = null,
    Object? status = null,
    Object? createdAt = null,
    Object? productType = null,
    Object? productQuantity = null,
  }) {
    return _then(_value.copyWith(
      deliveryId: null == deliveryId
          ? _value.deliveryId
          : deliveryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productType: null == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String,
      productQuantity: null == productQuantity
          ? _value.productQuantity
          : productQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeliveryImplCopyWith<$Res>
    implements $DeliveryCopyWith<$Res> {
  factory _$$DeliveryImplCopyWith(
          _$DeliveryImpl value, $Res Function(_$DeliveryImpl) then) =
      __$$DeliveryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String deliveryId,
      String name,
      String licenseNumber,
      String contactInfo,
      String status,
      DateTime createdAt,
      String productType,
      int productQuantity});
}

/// @nodoc
class __$$DeliveryImplCopyWithImpl<$Res>
    extends _$DeliveryCopyWithImpl<$Res, _$DeliveryImpl>
    implements _$$DeliveryImplCopyWith<$Res> {
  __$$DeliveryImplCopyWithImpl(
      _$DeliveryImpl _value, $Res Function(_$DeliveryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deliveryId = null,
    Object? name = null,
    Object? licenseNumber = null,
    Object? contactInfo = null,
    Object? status = null,
    Object? createdAt = null,
    Object? productType = null,
    Object? productQuantity = null,
  }) {
    return _then(_$DeliveryImpl(
      deliveryId: null == deliveryId
          ? _value.deliveryId
          : deliveryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      licenseNumber: null == licenseNumber
          ? _value.licenseNumber
          : licenseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      productType: null == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String,
      productQuantity: null == productQuantity
          ? _value.productQuantity
          : productQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeliveryImpl implements _Delivery {
  const _$DeliveryImpl(
      {required this.deliveryId,
      required this.name,
      required this.licenseNumber,
      required this.contactInfo,
      required this.status,
      required this.createdAt,
      required this.productType,
      required this.productQuantity});

  factory _$DeliveryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeliveryImplFromJson(json);

  @override
  final String deliveryId;
  @override
  final String name;
  @override
  final String licenseNumber;
  @override
  final String contactInfo;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final String productType;
// Added field for type of product
  @override
  final int productQuantity;

  @override
  String toString() {
    return 'Delivery(deliveryId: $deliveryId, name: $name, licenseNumber: $licenseNumber, contactInfo: $contactInfo, status: $status, createdAt: $createdAt, productType: $productType, productQuantity: $productQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryImpl &&
            (identical(other.deliveryId, deliveryId) ||
                other.deliveryId == deliveryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.licenseNumber, licenseNumber) ||
                other.licenseNumber == licenseNumber) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.productQuantity, productQuantity) ||
                other.productQuantity == productQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deliveryId, name, licenseNumber,
      contactInfo, status, createdAt, productType, productQuantity);

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryImplCopyWith<_$DeliveryImpl> get copyWith =>
      __$$DeliveryImplCopyWithImpl<_$DeliveryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeliveryImplToJson(
      this,
    );
  }
}

abstract class _Delivery implements Delivery {
  const factory _Delivery(
      {required final String deliveryId,
      required final String name,
      required final String licenseNumber,
      required final String contactInfo,
      required final String status,
      required final DateTime createdAt,
      required final String productType,
      required final int productQuantity}) = _$DeliveryImpl;

  factory _Delivery.fromJson(Map<String, dynamic> json) =
      _$DeliveryImpl.fromJson;

  @override
  String get deliveryId;
  @override
  String get name;
  @override
  String get licenseNumber;
  @override
  String get contactInfo;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  String get productType; // Added field for type of product
  @override
  int get productQuantity;

  /// Create a copy of Delivery
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryImplCopyWith<_$DeliveryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
