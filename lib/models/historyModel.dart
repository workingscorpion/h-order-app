import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final String serviceName;
  final String summary;
  final String detail;
  final int amount;
  final int status;
  final DateTime createdTime;

  HistoryModel({
    this.index,
    this.serviceName,
    this.summary,
    this.detail,
    this.amount,
    this.status,
    this.createdTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
