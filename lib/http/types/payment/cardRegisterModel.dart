import 'package:json_annotation/json_annotation.dart';

part 'cardRegisterModel.g.dart';

@JsonSerializable()
class CardRegisterModel {
  final String identity;
  final String cardNumber;
  final String cardPassword;
  final String expireMonth;
  final String expireYear;
  final String name;
  final String email;
  final String phone;

  CardRegisterModel({
    this.identity,
    this.cardNumber,
    this.cardPassword,
    this.expireMonth,
    this.expireYear,
    this.name,
    this.email,
    this.phone,
  });

  factory CardRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$CardRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardRegisterModelToJson(this);
}
