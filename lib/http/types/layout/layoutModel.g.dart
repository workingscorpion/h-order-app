// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layoutModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutModel _$LayoutModelFromJson(Map<String, dynamic> json) {
  return LayoutModel(
    objectId: json['objectId'] as String,
    name: json['name'] as String,
    positions: (json['positions'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    ),
  );
}

Map<String, dynamic> _$LayoutModelToJson(LayoutModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'positions': instance.positions,
    };
