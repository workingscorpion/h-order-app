import 'package:json_annotation/json_annotation.dart';

part 'itemModel.g.dart';

@JsonSerializable()
class ItemModel {
  final String objectId;
  final String type;
  final String value;
  final int max;
  final int price;
  final List<ItemModel> items;

  ItemModel({
    this.objectId,
    this.type,
    this.value,
    this.max,
    this.price,
    this.items,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
