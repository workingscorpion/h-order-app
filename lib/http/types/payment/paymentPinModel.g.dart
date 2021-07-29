// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentPinModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentPinModel _$PaymentPinModelFromJson(Map<String, dynamic> json) {
  return PaymentPinModel(
    pinNumber: json['pinNumber'] as String,
    pinExist: json['pinExist'] as bool,
  );
}

Map<String, dynamic> _$PaymentPinModelToJson(PaymentPinModel instance) =>
    <String, dynamic>{
      'pinNumber': instance.pinNumber,
      'pinExist': instance.pinExist,
    };
