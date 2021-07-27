import 'package:json_annotation/json_annotation.dart';

part 'paymentPinModel.g.dart';

@JsonSerializable()
class PaymentPinModel {
  final String pinNumber;

  PaymentPinModel({
    this.pinNumber,
  });

  factory PaymentPinModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentPinModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentPinModelToJson(this);
}
