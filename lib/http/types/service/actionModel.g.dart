// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionModel _$ActionModelFromJson(Map<String, dynamic> json) {
  return ActionModel(
    data: (json['data'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$ActionModelToJson(ActionModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
