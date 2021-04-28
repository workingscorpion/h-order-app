import 'package:json_annotation/json_annotation.dart';

part 'cardModel.g.dart';

@JsonSerializable()
class CardModel {
  final String BID;
  final String AuthDate;
  final String CardCode;
  final String CardName;
  final String CardCl;
  final String AcquCardCode;
  final String AcquCardName;
  final String resultCode;
  final String resultMsg;
  final String TID;

  CardModel({
    this.BID,
    this.AuthDate,
    this.CardCode,
    this.CardName,
    this.CardCl,
    this.AcquCardCode,
    this.AcquCardName,
    this.resultCode,
    this.resultMsg,
    this.TID,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
