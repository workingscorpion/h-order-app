// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    serviceObjectId: json['serviceObjectId'] as String,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'serviceObjectId': instance.serviceObjectId,
      'price': instance.price,
    };
