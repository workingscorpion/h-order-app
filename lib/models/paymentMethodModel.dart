import 'package:json_annotation/json_annotation.dart';

part 'paymentMethodModel.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  final int index;
  final String userObjectId;
  final String isPrimary;
  final String order;
  final String createdTime;

  PaymentMethodModel({
    this.index,
    this.userObjectId,
    this.isPrimary,
    this.order,
    this.createdTime,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}
