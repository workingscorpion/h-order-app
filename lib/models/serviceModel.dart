import 'package:h_order/models/itemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serviceModel.g.dart';

@JsonSerializable()
class ServiceModel {
  final String objectId;
  final String name;
  final String type;
  final String icon;
  final List<ItemModel> items;

  ServiceModel({
    this.objectId,
    this.name,
    this.type,
    this.icon,
    this.items,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
