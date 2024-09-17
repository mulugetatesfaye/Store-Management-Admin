// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      expenseId: json['expenseId'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      receiptImages: (json['receiptImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'type': instance.type,
      'receiptImages': instance.receiptImages,
    };
