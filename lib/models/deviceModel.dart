import 'package:json_annotation/json_annotation.dart';

part 'deviceModel.g.dart';

@JsonSerializable()
class DeviceModel {
  // final String deviceName;
  final String name;
  // final String address;

  // final String phone;
  // final String cellPhone;
  // final String emergencyPhone;

  // final DateTime contractStartDate;
  // final DateTime contractEndDate;

  // final String roomDetail;
  // final String contractType;

  // final List<String> items;

  // final List<String> bannerImages;
  // final List<String> serviceImages;

  DeviceModel({
    // this.deviceName,
    this.name,
    // this.address,
    // this.phone,
    // this.cellPhone,
    // this.emergencyPhone,
    // this.contractStartDate,
    // this.contractEndDate,
    // this.roomDetail,
    // this.contractType,
    // this.items,
    // this.bannerImages,
    // this.serviceImages,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
