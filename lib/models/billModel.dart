import 'package:json_annotation/json_annotation.dart';

part 'billModel.g.dart';

@JsonSerializable()
class BillModel {
  final String objectId;
  final int index;
  final String title;
  final String writer;
  final String contents;
  final int amount;
  final String userObjectId;
  final DateTime createdTime;
  final DateTime selectedMonth;
  final DateTime deadline;
  final DateTime paymentDate;

  BillModel({
    this.objectId,
    this.index,
    this.title,
    this.writer,
    this.contents,
    this.amount,
    this.userObjectId,
    this.createdTime,
    this.selectedMonth,
    this.deadline,
    this.paymentDate,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillModelToJson(this);
}
