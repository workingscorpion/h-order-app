import 'package:json_annotation/json_annotation.dart';

part 'productOptionModel.g.dart';

@JsonSerializable()
class ProductOptionModel {
  final int index;
  final String image;
  final String name;
  final int price;
  final List<ProductOptionModel> options;

  ProductOptionModel({
    this.index,
    this.image,
    this.name,
    this.price,
    this.options,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}
