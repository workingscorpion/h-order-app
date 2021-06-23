import 'package:json_annotation/json_annotation.dart';

part 'actionModel.g.dart';

@JsonSerializable()
class ActionModel {
  final Map<String, String> data;

  ActionModel({
    this.data,
  });

  factory ActionModel.fromJson(Map<String, dynamic> json) =>
      _$ActionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActionModelToJson(this);
}
