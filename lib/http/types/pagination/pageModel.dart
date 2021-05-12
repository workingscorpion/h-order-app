import 'package:json_annotation/json_annotation.dart';

part 'pageModel.g.dart';

@JsonSerializable()
class PageModel {
  final int total;
  final List list;

  PageModel({
    this.total,
    this.list,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageModelToJson(this);
}
