// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productOptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionModel _$ProductOptionModelFromJson(Map<String, dynamic> json) {
  return ProductOptionModel(
    index: json['index'] as int,
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

Map<String, dynamic> _$ProductOptionModelToJson(ProductOptionModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'options': instance.options,
    };
