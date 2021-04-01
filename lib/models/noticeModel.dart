import 'package:json_annotation/json_annotation.dart';

part 'noticeModel.g.dart';

@JsonSerializable()
class NoticeModel {
  final int index;
  final String title;
  final String writer;
  final String content;
  final int hit;
  final DateTime createdTime;

  NoticeModel({
    this.index,
    this.writer,
    this.title,
    this.content,
    this.hit,
    this.createdTime,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}