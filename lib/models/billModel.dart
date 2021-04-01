import 'package:json_annotation/json_annotation.dart';

part 'billModel.g.dart';

@JsonSerializable()
class BillModel {
  final int index;
  final String title;
  final DateTime expiredDate;
  final DateTime paymentDate;
  final int amount;
  final bool status;

  BillModel({
    this.index,
    this.title,
    this.expiredDate,
    this.paymentDate,
    this.amount,
    this.status,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) =>
      _$BillModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillModelToJson(this);
}
