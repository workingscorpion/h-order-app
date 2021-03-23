// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    index: json['index'] as int,
    product: json['product'] == null
        ? null
        : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    name: json['name'] as String,
    quantity: json['quantity'] as int,
    amount: json['amount'] as int,
    optionAmount: json['optionAmount'] as int,
    totalAmount: json['totalAmount'] as int,
    optionQuantity: (json['optionQuantity'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'index': instance.index,
      'product': instance.product,
      'name': instance.name,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'optionAmount': instance.optionAmount,
      'totalAmount': instance.totalAmount,
      'optionQuantity':
          instance.optionQuantity?.map((k, e) => MapEntry(k.toString(), e)),
    };
