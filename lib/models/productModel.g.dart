// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    objectId: json['objectId'] as String,
    categoryObjectId: json['categoryObjectId'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
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
      'objectId': instance.objectId,
      'categoryObjectId': instance.categoryObjectId,
      'images': instance.images,
      'name': instance.name,
      'price': instance.price,
      'options': instance.options,
    };
