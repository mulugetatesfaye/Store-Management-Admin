// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
      productName: json['productName'] as String,
      saleId: json['saleId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      pricePerUnit: (json['pricePerUnit'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      remainingAmount: (json['remainingAmount'] as num).toDouble(),
      soldBy: json['soldBy'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      receiptImages: (json['receiptImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'saleId': instance.saleId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'pricePerUnit': instance.pricePerUnit,
      'totalPrice': instance.totalPrice,
      'paidAmount': instance.paidAmount,
      'remainingAmount': instance.remainingAmount,
      'soldBy': instance.soldBy,
      'saleDate': instance.saleDate.toIso8601String(),
      'imageUrls': instance.imageUrls,
      'receiptImages': instance.receiptImages,
    };
