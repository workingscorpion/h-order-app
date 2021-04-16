// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return ItemModel(
    objectId: json['objectId'] as String,
    type: json['type'] as String,
    value: json['value'] as String,
    min: json['min'] as int,
    max: json['max'] as int,
    children: (json['children'] as List)
        ?.map((e) =>
            e == null ? null : ItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'objectId': instance.objectId,
      'type': instance.type,
      'value': instance.value,
      'min': instance.min,
      'max': instance.max,
      'children': instance.children,
    };
