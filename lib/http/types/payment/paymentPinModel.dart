import 'package:json_annotation/json_annotation.dart';

part 'paymentPinModel.g.dart';

@JsonSerializable()
class PaymentPinModel {
  final String pinNumber;
  final bool pinExist;

  PaymentPinModel({
    this.pinNumber,
    this.pinExist,
  });

  factory PaymentPinModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentPinModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentPinModelToJson(this);
}
