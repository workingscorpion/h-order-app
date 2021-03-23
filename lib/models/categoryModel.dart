import 'package:h_order/models/productModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryModel.g.dart';

@JsonSerializable()
class CategoryModel {
  final int index;
  final String name;
  final List<ProductModel> products;

  CategoryModel({
    this.index,
    this.name,
    this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
