// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productOptionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionModel _$ProductOptionModelFromJson(Map<String, dynamic> json) {
  return ProductOptionModel(
    objectId: json['objectId'] as String,
    parentObjectId: json['parentObjectId'] as String,
    image: json['image'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    multiple: json['multiple'] as bool,
    max: json['max'] as int,
    isRequired: json['isRequired'] as bool,
    options: (json['options'] as List)
        ?.map((e) => e == null
            ? null
            : ProductOptionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductOptionModelToJson(ProductOptionModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'parentObjectId': instance.parentObjectId,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'multiple': instance.multiple,
      'max': instance.max,
      'isRequired': instance.isRequired,
      'options': instance.options,
    };
