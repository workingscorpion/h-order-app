// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return BillModel(
    index: json['index'] as int,
    title: json['title'] as String,
    expiredDate: json['expiredDate'] == null
        ? null
        : DateTime.parse(json['expiredDate'] as String),
    paymentDate: json['paymentDate'] == null
        ? null
        : DateTime.parse(json['paymentDate'] as String),
    amount: json['amount'] as int,
    status: json['status'] as bool,
  );
}

Map<String, dynamic> _$BillModelToJson(BillModel instance) => <String, dynamic>{
      'index': instance.index,
      'title': instance.title,
      'expiredDate': instance.expiredDate?.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'amount': instance.amount,
      'status': instance.status,
    };
