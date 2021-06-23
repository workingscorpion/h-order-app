// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return BillModel(
    objectId: json['objectId'] as String,
    index: json['index'] as int,
    title: json['title'] as String,
    writer: json['writer'] as String,
    contents: json['contents'] as String,
    amount: json['amount'] as int,
    userObjectId: json['userObjectId'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
    selectedMonth: json['selectedMonth'] == null
        ? null
        : DateTime.parse(json['selectedMonth'] as String),
    deadline: json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String),
    paymentDate: json['paymentDate'] == null
        ? null
        : DateTime.parse(json['paymentDate'] as String),
  );
}

Map<String, dynamic> _$BillModelToJson(BillModel instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'index': instance.index,
      'title': instance.title,
      'writer': instance.writer,
      'contents': instance.contents,
      'amount': instance.amount,
      'userObjectId': instance.userObjectId,
      'createdTime': instance.createdTime?.toIso8601String(),
      'selectedMonth': instance.selectedMonth?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
    };
