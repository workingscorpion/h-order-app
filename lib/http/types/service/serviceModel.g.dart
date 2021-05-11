// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return ServiceModel(
    objectId: json['objectId'] as String,
    name: json['name'] as String,
    image: json['image'] as String,
    type: json['type'] as String,
    enabled: json['enabled'] as bool,
    processing: json['processing'] as bool,
    status: (json['status'] as List)?.map((e) => e as int)?.toList(),
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'image': instance.image,
      'type': instance.type,
      'enabled': instance.enabled,
      'processing': instance.processing,
      'status': instance.status,
      'items': instance.items,
    };
