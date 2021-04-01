import 'package:json_annotation/json_annotation.dart';

part 'keyValueModel.g.dart';

@JsonSerializable()
class KeyValueModel {
  final String key;
  final int value;
  final int price;

  KeyValueModel({
    this.key,
    this.value,
    this.price,
  });

  factory KeyValueModel.fromJson(Map<String, dynamic> json) =>
      _$KeyValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$KeyValueModelToJson(this);
}
