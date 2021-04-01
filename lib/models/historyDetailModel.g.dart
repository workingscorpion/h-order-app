// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailModel _$HistoryDetailModelFromJson(Map<String, dynamic> json) {
  return HistoryDetailModel(
    title: json['title'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    amount: json['amount'] as int,
    paymentMethod: json['paymentMethod'] as String,
    paymentData: json['paymentData'] as String,
    detail: (json['detail'] as List)
        ?.map((e) => e == null
            ? null
            : KeyValueModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reservedTime: json['reservedTime'] == null
        ? null
        : DateTime.parse(json['reservedTime'] as String),
    request: json['request'] as String,
  );
}

Map<String, dynamic> _$HistoryDetailModelToJson(HistoryDetailModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createdTime': instance.createdTime?.toIso8601String(),
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'paymentData': instance.paymentData,
      'detail': instance.detail,
      'reservedTime': instance.reservedTime?.toIso8601String(),
      'request': instance.request,
    };
