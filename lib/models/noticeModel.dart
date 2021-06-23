import 'package:json_annotation/json_annotation.dart';

part 'noticeModel.g.dart';

@JsonSerializable()
class NoticeModel {
  final String objectId;
  final int index;
  final String title;
  final String writer;
  final String contents;
  final DateTime createdTime;

  NoticeModel({
    this.objectId,
    this.index,
    this.writer,
    this.title,
    this.contents,
    this.createdTime,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);
}
