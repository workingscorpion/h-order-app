import 'package:h_order/models/historyDetailModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final String serviceName;
  final String summary;
  final int amount;
  final int status;
  final DateTime createdTime;
  final HistoryDetailModel detail;

  HistoryModel({
    this.index,
    this.serviceName,
    this.summary,
    this.amount,
    this.status,
    this.createdTime,
    this.detail,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
