import 'package:json_annotation/json_annotation.dart';

part 'requestTermsModel.g.dart';

@JsonSerializable()
class RequestTermsModel {
  final bool terms;

  RequestTermsModel({
    this.terms,
  });

  factory RequestTermsModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTermsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTermsModelToJson(this);
}
