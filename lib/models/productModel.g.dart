// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    index: json['index'] as int,
    categoryIndex: json['categoryIndex'] as int,
    image: json['image'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    options: (json['options'] as List)
        ?.map((e) => e == null
            ? null
            : ProductOptionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'categoryIndex': instance.categoryIndex,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'options': instance.options,
    };
