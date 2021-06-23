// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestLoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestLoginModel _$RequestLoginModelFromJson(Map<String, dynamic> json) {
  return RequestLoginModel(
    serialNumber: json['serialNumber'] as String,
    deviceId: json['deviceId'] as String,
    deviceToken: json['deviceToken'] as String,
  );
}

Map<String, dynamic> _$RequestLoginModelToJson(RequestLoginModel instance) =>
    <String, dynamic>{
      'serialNumber': instance.serialNumber,
      'deviceId': instance.deviceId,
      'deviceToken': instance.deviceToken,
    };
