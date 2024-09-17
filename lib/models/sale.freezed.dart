// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  String get productName => throw _privateConstructorUsedError;
  String get saleId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get pricePerUnit => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  double get remainingAmount => throw _privateConstructorUsedError;
  String get soldBy => throw _privateConstructorUsedError;
  DateTime get saleDate => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<String> get receiptImages => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call(
      {String productName,
      String saleId,
      String productId,
      int quantity,
      double pricePerUnit,
      double totalPrice,
      double paidAmount,
      double remainingAmount,
      String soldBy,
      DateTime saleDate,
      List<String> imageUrls,
      List<String> receiptImages});
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? saleId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? pricePerUnit = null,
    Object? totalPrice = null,
    Object? paidAmount = null,
    Object? remainingAmount = null,
    Object? soldBy = null,
    Object? saleDate = null,
    Object? imageUrls = null,
    Object? receiptImages = null,
  }) {
    return _then(_value.copyWith(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
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
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      soldBy: null == soldBy
          ? _value.soldBy
          : soldBy // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      receiptImages: null == receiptImages
          ? _value.receiptImages
          : receiptImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
          _$SaleImpl value, $Res Function(_$SaleImpl) then) =
      __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productName,
      String saleId,
      String productId,
      int quantity,
      double pricePerUnit,
      double totalPrice,
      double paidAmount,
      double remainingAmount,
      String soldBy,
      DateTime saleDate,
      List<String> imageUrls,
      List<String> receiptImages});
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = null,
    Object? saleId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? pricePerUnit = null,
    Object? totalPrice = null,
    Object? paidAmount = null,
    Object? remainingAmount = null,
    Object? soldBy = null,
    Object? saleDate = null,
    Object? imageUrls = null,
    Object? receiptImages = null,
  }) {
    return _then(_$SaleImpl(
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
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
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      soldBy: null == soldBy
          ? _value.soldBy
          : soldBy // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      receiptImages: null == receiptImages
          ? _value._receiptImages
          : receiptImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl(
      {required this.productName,
      required this.saleId,
      required this.productId,
      required this.quantity,
      required this.pricePerUnit,
      required this.totalPrice,
      required this.paidAmount,
      required this.remainingAmount,
      required this.soldBy,
      required this.saleDate,
      final List<String> imageUrls = const [],
      final List<String> receiptImages = const []})
      : _imageUrls = imageUrls,
        _receiptImages = receiptImages;

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  final String productName;
  @override
  final String saleId;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final double pricePerUnit;
  @override
  final double totalPrice;
  @override
  final double paidAmount;
  @override
  final double remainingAmount;
  @override
  final String soldBy;
  @override
  final DateTime saleDate;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<String> _receiptImages;
  @override
  @JsonKey()
  List<String> get receiptImages {
    if (_receiptImages is EqualUnmodifiableListView) return _receiptImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receiptImages);
  }

  @override
  String toString() {
    return 'Sale(productName: $productName, saleId: $saleId, productId: $productId, quantity: $quantity, pricePerUnit: $pricePerUnit, totalPrice: $totalPrice, paidAmount: $paidAmount, remainingAmount: $remainingAmount, soldBy: $soldBy, saleDate: $saleDate, imageUrls: $imageUrls, receiptImages: $receiptImages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.pricePerUnit, pricePerUnit) ||
                other.pricePerUnit == pricePerUnit) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount) &&
            (identical(other.soldBy, soldBy) || other.soldBy == soldBy) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            const DeepCollectionEquality()
                .equals(other._receiptImages, _receiptImages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productName,
      saleId,
      productId,
      quantity,
      pricePerUnit,
      totalPrice,
      paidAmount,
      remainingAmount,
      soldBy,
      saleDate,
      const DeepCollectionEquality().hash(_imageUrls),
      const DeepCollectionEquality().hash(_receiptImages));

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(
      this,
    );
  }
}

abstract class _Sale implements Sale {
  const factory _Sale(
      {required final String productName,
      required final String saleId,
      required final String productId,
      required final int quantity,
      required final double pricePerUnit,
      required final double totalPrice,
      required final double paidAmount,
      required final double remainingAmount,
      required final String soldBy,
      required final DateTime saleDate,
      final List<String> imageUrls,
      final List<String> receiptImages}) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  String get productName;
  @override
  String get saleId;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  double get pricePerUnit;
  @override
  double get totalPrice;
  @override
  double get paidAmount;
  @override
  double get remainingAmount;
  @override
  String get soldBy;
  @override
  DateTime get saleDate;
  @override
  List<String> get imageUrls;
  @override
  List<String> get receiptImages;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
