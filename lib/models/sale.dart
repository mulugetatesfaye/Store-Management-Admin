import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    required String productName,
    required String saleId,
    required String productId,
    required int quantity,
    required double pricePerUnit,
    required double totalPrice,
    required double paidAmount,
    required double remainingAmount,
    required String soldBy,
    required DateTime saleDate,
    @Default([]) List<String> imageUrls,
    @Default([]) List<String> receiptImages,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}
