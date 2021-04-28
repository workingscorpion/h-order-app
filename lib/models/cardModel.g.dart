// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cardModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) {
  return CardModel(
    BID: json['BID'] as String,
    AuthDate: json['AuthDate'] as String,
    CardCode: json['CardCode'] as String,
    CardName: json['CardName'] as String,
    CardCl: json['CardCl'] as String,
    AcquCardCode: json['AcquCardCode'] as String,
    AcquCardName: json['AcquCardName'] as String,
    resultCode: json['resultCode'] as String,
    resultMsg: json['resultMsg'] as String,
    TID: json['TID'] as String,
  );
}

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'BID': instance.BID,
      'AuthDate': instance.AuthDate,
      'CardCode': instance.CardCode,
      'CardName': instance.CardName,
      'CardCl': instance.CardCl,
      'AcquCardCode': instance.AcquCardCode,
      'AcquCardName': instance.AcquCardName,
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
      'TID': instance.TID,
    };
