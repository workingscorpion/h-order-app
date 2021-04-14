// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) {
  return NoticeModel(
    index: json['index'] as int,
    writer: json['writer'] as String,
    title: json['title'] as String,
    content: json['content'] as String,
    createdTime: json['createdTime'] == null
        ? null
        : DateTime.parse(json['createdTime'] as String),
  );
}

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'title': instance.title,
      'writer': instance.writer,
      'content': instance.content,
      'createdTime': instance.createdTime?.toIso8601String(),
    };
