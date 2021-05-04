import 'package:json_annotation/json_annotation.dart';

part 'layoutModel.g.dart';

@JsonSerializable()
class LayoutModel {
  final String objectId;
  final String name;
  final Map<String, List<String>> positions;

  LayoutModel({
    this.objectId,
    this.name,
    this.positions,
  });

  factory LayoutModel.fromJson(Map<String, dynamic> json) =>
      _$LayoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutModelToJson(this);
}
