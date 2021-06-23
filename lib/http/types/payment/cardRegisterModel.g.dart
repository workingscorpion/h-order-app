// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardRegisterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardRegisterModel _$CardRegisterModelFromJson(Map<String, dynamic> json) {
  return CardRegisterModel(
    identity: json['identity'] as String,
    cardNumber: json['cardNumber'] as String,
    cardPassword: json['cardPassword'] as String,
    expireMonth: json['expireMonth'] as String,
    expireYear: json['expireYear'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$CardRegisterModelToJson(CardRegisterModel instance) =>
    <String, dynamic>{
      'identity': instance.identity,
      'cardNumber': instance.cardNumber,
      'cardPassword': instance.cardPassword,
      'expireMonth': instance.expireMonth,
      'expireYear': instance.expireYear,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
