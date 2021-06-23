import 'package:h_order/models/itemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cartItemModel.g.dart';

@JsonSerializable()
class CartItemModel {
  static const minQuantity = 1;

  final ItemModel product;
  final String name;
  final int amount;
  final int optionAmount;
  final Map<String, int> optionQuantity;

  int get totalAmount {
    return _quantity * (amount + optionAmount);
  }

  int get quantity {
    return _quantity;
  }

  int _quantity;

  get key {
    final list = optionQuantity.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final options = list.map((element) {
      final _key = Uri.encodeComponent(element.key);
      final _value = element.value.toString();
      return '$_key=$_value';
    });

    return '${product.objectId}?' + options.join('&');
  }

  CartItemModel({
    this.product,
    this.name,
    int quantity,
    this.amount,
    this.optionAmount,
    this.optionQuantity,
  }) : _quantity = quantity;

  add(int value) {
    _quantity += value;
  }

  subtract(int value) {
    _quantity -= value;
    if (_quantity < minQuantity) {
      _quantity = minQuantity;
    }
  }

  operator +(CartItemModel item) {
    assert(key == item.key, 'both cart item key must be same.');
    assert(amount == item.amount, 'both cart item amount must be same.');
    assert(optionAmount == item.optionAmount,
        'both cart item optionAmount must be same.');

    final _quantity = quantity + item.quantity;

    return CartItemModel(
      quantity: _quantity,
      product: product,
      name: name,
      amount: amount,
      optionAmount: optionAmount,
      optionQuantity: optionQuantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
