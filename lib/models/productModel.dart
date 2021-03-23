import 'package:h_order/models/productOptionModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productModel.g.dart';

@JsonSerializable()
class ProductModel {
  final int index;
  final String image;
  final String name;
  final int price;
  final List<ProductOptionModel> options;

  ProductModel({
    this.index,
    this.image,
    this.name,
    this.price,
    this.options,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
