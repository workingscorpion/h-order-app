import 'package:json_annotation/json_annotation.dart';

part 'productOptionModel.g.dart';

@JsonSerializable()
class ProductOptionModel {
  final int index;
  final int parent;
  final String image;
  final String name;
  final int price;
  final bool multiple;
  final int max;
  final List<ProductOptionModel> options;

  ProductOptionModel({
    this.index,
    this.parent,
    this.image,
    this.name,
    this.price,
    this.multiple,
    this.max,
    this.options,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}
