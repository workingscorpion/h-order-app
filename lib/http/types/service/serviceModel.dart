import 'package:h_order/models/itemModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serviceModel.g.dart';

@JsonSerializable()
class ServiceModel {
  final String objectId;
  final String name;
  final String image;
  final String type;
  final bool enabled;
  final bool processing;
  final List<int> status;
  final List<ItemModel> items;

  ServiceModel({
    this.objectId,
    this.name,
    this.image,
    this.type,
    this.enabled,
    this.processing,
    this.status,
    this.items,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
