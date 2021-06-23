import 'package:json_annotation/json_annotation.dart';

part 'orderModel.g.dart';

@JsonSerializable()
class OrderModel {
  final String serviceObjectId;
  final int price;

  OrderModel({
    this.serviceObjectId,
    this.price,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
