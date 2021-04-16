import 'package:json_annotation/json_annotation.dart';

part 'itemModel.g.dart';

@JsonSerializable()
class ItemModel {
  final String objectId;
  final String type;
  final String value;
  final int min;
  final int max;
  final List<ItemModel> children;

  ItemModel({
    this.objectId,
    this.type,
    this.value,
    this.min,
    this.max,
    this.children,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
