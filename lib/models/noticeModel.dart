import 'package:json_annotation/json_annotation.dart';

part 'noticeModel.g.dart';

@JsonSerializable()
class NoticeModel {
  final int index;
  final String title;
  final String writer;
  final String content;
  final DateTime createdTime;
  final bool isRead;

  NoticeModel({
    this.index,
    this.writer,
    this.title,
    this.content,
    this.createdTime,
    this.isRead,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}
