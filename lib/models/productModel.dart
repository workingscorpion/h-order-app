import 'package:h_order/models/productOptionModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productModel.g.dart';

@JsonSerializable()
class ProductModel {
  final String objectId;
  final String categoryObjectId;
  final List<String> images;
  final String name;
  final int price;
  final List<ProductOptionModel> options;

  ProductModel({
    this.objectId,
    this.categoryObjectId,
    this.images,
    this.name,
    this.price,
    this.options,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
