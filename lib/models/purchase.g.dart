// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseImpl _$$PurchaseImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseImpl(
      productName: json['productName'] as String,
      purchaseId: json['purchaseId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      pricePerUnit: (json['pricePerUnit'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      supplier: json['supplier'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$PurchaseImplToJson(_$PurchaseImpl instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'purchaseId': instance.purchaseId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'pricePerUnit': instance.pricePerUnit,
      'totalPrice': instance.totalPrice,
      'supplier': instance.supplier,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'imageUrls': instance.imageUrls,
    };
