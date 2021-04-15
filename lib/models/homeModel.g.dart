// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    room: json['room'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    cellPhone: json['cellPhone'] as String,
    emergencyPhone: json['emergencyPhone'] as String,
    contractStartDate: json['contractStartDate'] == null
        ? null
        : DateTime.parse(json['contractStartDate'] as String),
    contractEndDate: json['contractEndDate'] == null
        ? null
        : DateTime.parse(json['contractEndDate'] as String),
    roomDetail: json['roomDetail'] as String,
    contractType: json['contractType'] as String,
    items: (json['items'] as List)?.map((e) => e as String)?.toList(),
    bannerImages:
        (json['bannerImages'] as List)?.map((e) => e as String)?.toList(),
    serviceImages:
        (json['serviceImages'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'room': instance.room,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'cellPhone': instance.cellPhone,
      'emergencyPhone': instance.emergencyPhone,
      'contractStartDate': instance.contractStartDate?.toIso8601String(),
      'contractEndDate': instance.contractEndDate?.toIso8601String(),
      'roomDetail': instance.roomDetail,
      'contractType': instance.contractType,
      'items': instance.items,
      'bannerImages': instance.bannerImages,
      'serviceImages': instance.serviceImages,
    };
