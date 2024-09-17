import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

@freezed
class Delivery with _$Delivery {
  const factory Delivery({
    required String deliveryId,
    required String name,
    required String licenseNumber,
    required String contactInfo,
    required String status,
    required DateTime createdAt,
    required String productType, // Added field for type of product
    required int productQuantity, // Added field for quantity of product
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}
