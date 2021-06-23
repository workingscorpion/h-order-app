import 'package:h_order/models/historyDetailModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyModel.g.dart';

@JsonSerializable()
class HistoryModel {
  final int index;
  final int status;
  final String serviceObjectId;
  final String serviceName;
  final String summary;
  final String data;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String userObjectId;
  final String userName;
  final String deviceObjectId;
  final String deviceName;
  final int amount;
  final int quantity;
  final HistoryDetailModel detail;

  HistoryModel({
    this.index,
    this.status,
    this.serviceObjectId,
    this.serviceName,
    this.summary,
    this.data,
    this.createdTime,
    this.updatedTime,
    this.userObjectId,
    this.userName,
    this.deviceObjectId,
    this.deviceName,
    this.amount,
    this.quantity,
    this.detail,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
