// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    index: json['index'] as int,
    name: json['name'] as String,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'products': instance.products,
    };
