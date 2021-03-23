import 'package:h_order/models/productModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cartModel.g.dart';

@JsonSerializable()
class CartModel {
  final int index;
  final ProductModel product;
  final String name;
  final int quantity;
  final int amount;
  final int optionAmount;
  final int totalAmount;
  final Map<int, int> optionQuantity;

  CartModel({
    this.index,
    this.product,
    this.name,
    this.quantity,
    this.amount,
    this.optionAmount,
    this.totalAmount,
    this.optionQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
