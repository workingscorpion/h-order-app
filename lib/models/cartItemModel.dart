import 'package:h_order/models/productModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cartItemModel.g.dart';

@JsonSerializable()
class CartItemModel {
  final int index;
  final ProductModel product;
  final String name;
  final int quantity;
  final int amount;
  final int optionAmount;
  final int totalAmount;
  final Map<int, int> optionQuantity;

  CartItemModel({
    this.index,
    this.product,
    this.name,
    this.quantity,
    this.amount,
    this.optionAmount,
    this.totalAmount,
    this.optionQuantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
