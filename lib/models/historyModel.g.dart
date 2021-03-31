// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    index: json['index'] as int,
    serviceName: json['serviceName'] as String,
    summary: json['summary'] as String,
    detail: json['detail'] as String,
    amount: json['amount'] as int,
    status: json['status'] as int,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'serviceName': instance.serviceName,
      'summary': instance.summary,
      'detail': instance.detail,
      'amount': instance.amount,
      'status': instance.status,
      'createdTime': instance.createdTime?.toIso8601String(),
    };
