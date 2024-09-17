// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeliveryImpl _$$DeliveryImplFromJson(Map<String, dynamic> json) =>
    _$DeliveryImpl(
      deliveryId: json['deliveryId'] as String,
      name: json['name'] as String,
      licenseNumber: json['licenseNumber'] as String,
      contactInfo: json['contactInfo'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      productType: json['productType'] as String,
      productQuantity: (json['productQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$$DeliveryImplToJson(_$DeliveryImpl instance) =>
    <String, dynamic>{
      'deliveryId': instance.deliveryId,
      'name': instance.name,
      'licenseNumber': instance.licenseNumber,
      'contactInfo': instance.contactInfo,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'productType': instance.productType,
      'productQuantity': instance.productQuantity,
    };
