// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damaged_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DamagedProductImpl _$$DamagedProductImplFromJson(Map<String, dynamic> json) =>
    _$DamagedProductImpl(
      damagedProductId: json['damagedProductId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      reason: json['reason'] as String,
      reportedAt: DateTime.parse(json['reportedAt'] as String),
    );

Map<String, dynamic> _$$DamagedProductImplToJson(
        _$DamagedProductImpl instance) =>
    <String, dynamic>{
      'damagedProductId': instance.damagedProductId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'reason': instance.reason,
      'reportedAt': instance.reportedAt.toIso8601String(),
    };
