// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentMethodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) {
  return PaymentMethodModel(
    index: json['index'] as int,
    userObjectId: json['userObjectId'] as String,
    isPrimary: json['isPrimary'] as bool,
    order: json['order'] as int,
    bankCode: json['bankCode'] as String,
    cardLastNumber: json['cardLastNumber'] as String,
    createdTime: json['createdTime'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodModelToJson(PaymentMethodModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'userObjectId': instance.userObjectId,
      'isPrimary': instance.isPrimary,
      'order': instance.order,
      'bankCode': instance.bankCode,
      'cardLastNumber': instance.cardLastNumber,
      'createdTime': instance.createdTime,
    };
