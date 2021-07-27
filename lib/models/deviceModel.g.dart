// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) {
  return DeviceModel(
    name: json['name'] as String,
    boundaryAddress: json['boundaryAddress'] as String,
    boundaryName: json['boundaryName'] as String,
    terms: json['terms'] as bool,
    pinNumber: json['pinNumber'] as String,
  );
}

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'boundaryAddress': instance.boundaryAddress,
      'boundaryName': instance.boundaryName,
      'terms': instance.terms,
      'pinNumber': instance.pinNumber,
    };
