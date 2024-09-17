import 'package:freezed_annotation/freezed_annotation.dart';

part 'damaged_product.freezed.dart';
part 'damaged_product.g.dart';

@freezed
class DamagedProduct with _$DamagedProduct {
  const factory DamagedProduct({
    required String damagedProductId,
    required String productName,
    required int quantity,
    required String reason,
    required DateTime reportedAt,
  }) = _DamagedProduct;

  factory DamagedProduct.fromJson(Map<String, dynamic> json) =>
      _$DamagedProductFromJson(json);
}
