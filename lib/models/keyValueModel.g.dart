// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyValueModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueModel _$KeyValueModelFromJson(Map<String, dynamic> json) {
  return KeyValueModel(
    key: json['key'] as String,
    value: json['value'] as int,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$KeyValueModelToJson(KeyValueModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'price': instance.price,
    };
