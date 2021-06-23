import 'package:json_annotation/json_annotation.dart';

part 'paymentMethodModel.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  final int index;
  final String userObjectId;
  final String objectId;
  final bool isPrimary;
  final int order;
  final String bankCode;
  final String cardLastNumber;
  final String createdTime;

  PaymentMethodModel({
    this.index,
    this.userObjectId,
    this.objectId,
    this.isPrimary,
    this.order,
    this.bankCode,
    this.cardLastNumber,
    this.createdTime,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}
