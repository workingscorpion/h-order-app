import 'package:json_annotation/json_annotation.dart';

part 'requestLoginModel.g.dart';

@JsonSerializable()
class RequestLoginModel {
  String serialNumber;
  String deviceId;
  String deviceToken;

  RequestLoginModel({
    this.serialNumber,
    this.deviceId,
    this.deviceToken,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) =>
      _$RequestLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestLoginModelToJson(this);
}
