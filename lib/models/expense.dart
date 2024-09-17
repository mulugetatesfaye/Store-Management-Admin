import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  factory Expense({
    required String expenseId,
    required String description,
    required double amount,
    required DateTime date,
    required String type, // e.g., "Operational", "Miscellaneous"
    @Default([]) List<String> receiptImages,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
