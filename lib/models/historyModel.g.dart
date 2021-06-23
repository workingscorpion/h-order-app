// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    index: json['index'] as int,
    status: json['status'] as int,
    serviceObjectId: json['serviceObjectId'] as String,
    serviceName: json['serviceName'] as String,
    summary: json['summary'] as String,
    data: json['data'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    updatedTime: json['updatedTime'] == null
        ? null
        : DateTime.parse(json['updatedTime'] as String),
    userObjectId: json['userObjectId'] as String,
    userName: json['userName'] as String,
    deviceObjectId: json['deviceObjectId'] as String,
    deviceName: json['deviceName'] as String,
    amount: json['amount'] as int,
    quantity: json['quantity'] as int,
    detail: json['detail'] == null
        ? null
        : HistoryDetailModel.fromJson(json['detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'status': instance.status,
      'serviceObjectId': instance.serviceObjectId,
      'serviceName': instance.serviceName,
      'summary': instance.summary,
      'data': instance.data,
      'createdTime': instance.createdTime?.toIso8601String(),
      'updatedTime': instance.updatedTime?.toIso8601String(),
      'userObjectId': instance.userObjectId,
      'userName': instance.userName,
      'deviceObjectId': instance.deviceObjectId,
      'deviceName': instance.deviceName,
      'amount': instance.amount,
      'quantity': instance.quantity,
      'detail': instance.detail,
    };
