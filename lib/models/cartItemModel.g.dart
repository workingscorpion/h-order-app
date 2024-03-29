// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) {
  return CartItemModel(
    product: json['product'] == null
        ? null
        : ItemModel.fromJson(json['product'] as Map<String, dynamic>),
    name: json['name'] as String,
    quantity: json['quantity'] as int,
    amount: json['amount'] as int,
    optionAmount: json['optionAmount'] as int,
    optionQuantity: (json['optionQuantity'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'name': instance.name,
      'amount': instance.amount,
      'optionAmount': instance.optionAmount,
      'optionQuantity': instance.optionQuantity,
      'quantity': instance.quantity,
    };
