import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  factory Purchase({
    required String productName, // Added field for product name
    required String purchaseId,
    required String productId,
    required int quantity,
    required double pricePerUnit,
    required double totalPrice,
    required String supplier,
    required DateTime purchaseDate,
    List<String>? imageUrls,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}
