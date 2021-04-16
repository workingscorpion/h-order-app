import 'package:json_annotation/json_annotation.dart';

part 'productOptionModel.g.dart';

@JsonSerializable()
class ProductOptionModel {
  final String objectId;
  final String parentObjectId;
  final String image;
  final String name;
  final int price;
  final bool multiple;
  final int max;
  final bool isRequired;
  final List<ProductOptionModel> options;

  ProductOptionModel({
    this.objectId,
    this.parentObjectId,
    this.image,
    this.name,
    this.price,
    this.multiple,
    this.max,
    this.isRequired,
    this.options,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}
