// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  String get productName =>
      throw _privateConstructorUsedError; // Added field for product name
  String get purchaseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get pricePerUnit => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  String get supplier => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this Purchase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call(
      {String productName,
      String purchaseId,
      String productId,
      int quantity,
      double pricePerUnit,
      double totalPrice,
      String supplier,
      DateTime purchaseDate,
      List<String>? imageUrls});
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? purchaseId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? pricePerUnit = null,
    Object? totalPrice = null,
    Object? supplier = null,
    Object? purchaseDate = null,
    Object? imageUrls = freezed,
  }) {
    return _then(_value.copyWith(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerUnit: null == pricePerUnit
          ? _value.pricePerUnit
          : pricePerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res>
    implements $PurchaseCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
          _$PurchaseImpl value, $Res Function(_$PurchaseImpl) then) =
      __$$PurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productName,
      String purchaseId,
      String productId,
      int quantity,
      double pricePerUnit,
      double totalPrice,
      String supplier,
      DateTime purchaseDate,
      List<String>? imageUrls});
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
      _$PurchaseImpl _value, $Res Function(_$PurchaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? purchaseId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? pricePerUnit = null,
    Object? totalPrice = null,
    Object? supplier = null,
    Object? purchaseDate = null,
    Object? imageUrls = freezed,
  }) {
    return _then(_$PurchaseImpl(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerUnit: null == pricePerUnit
          ? _value.pricePerUnit
          : pricePerUnit // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      supplier: null == supplier
          ? _value.supplier
          : supplier // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseImpl implements _Purchase {
  _$PurchaseImpl(
      {required this.productName,
      required this.purchaseId,
      required this.productId,
      required this.quantity,
      required this.pricePerUnit,
      required this.totalPrice,
      required this.supplier,
      required this.purchaseDate,
      final List<String>? imageUrls})
      : _imageUrls = imageUrls;

  factory _$PurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseImplFromJson(json);

  @override
  final String productName;
// Added field for product name
  @override
  final String purchaseId;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final double pricePerUnit;
  @override
  final double totalPrice;
  @override
  final String supplier;
  @override
  final DateTime purchaseDate;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Purchase(productName: $productName, purchaseId: $purchaseId, productId: $productId, quantity: $quantity, pricePerUnit: $pricePerUnit, totalPrice: $totalPrice, supplier: $supplier, purchaseDate: $purchaseDate, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.pricePerUnit, pricePerUnit) ||
                other.pricePerUnit == pricePerUnit) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productName,
      purchaseId,
      productId,
      quantity,
      pricePerUnit,
      totalPrice,
      supplier,
      purchaseDate,
      const DeepCollectionEquality().hash(_imageUrls));

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseImplToJson(
      this,
    );
  }
}

abstract class _Purchase implements Purchase {
  factory _Purchase(
      {required final String productName,
      required final String purchaseId,
      required final String productId,
      required final int quantity,
      required final double pricePerUnit,
      required final double totalPrice,
      required final String supplier,
      required final DateTime purchaseDate,
      final List<String>? imageUrls}) = _$PurchaseImpl;

  factory _Purchase.fromJson(Map<String, dynamic> json) =
      _$PurchaseImpl.fromJson;

  @override
  String get productName; // Added field for product name
  @override
  String get purchaseId;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  double get pricePerUnit;
  @override
  double get totalPrice;
  @override
  String get supplier;
  @override
  DateTime get purchaseDate;
  @override
  List<String>? get imageUrls;

  /// Create a copy of Purchase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
