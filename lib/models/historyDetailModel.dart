import 'package:h_order/models/keyValueModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyDetailModel.g.dart';

@JsonSerializable()
class HistoryDetailModel {
  final String title;
  final DateTime createdTime;
  final int amount;
  final String paymentMethod;
  final String paymentData;
  final List<KeyValueModel> detail;
  final DateTime reservedTime;
  final String request;

  HistoryDetailModel({
    this.title,
    this.createdTime,
    this.amount,
    this.paymentMethod,
    this.paymentData,
    this.detail,
    this.reservedTime,
    this.request,
  });

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}
