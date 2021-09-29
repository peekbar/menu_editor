import 'package:json_annotation/json_annotation.dart';

part 'imprint.g.dart';

@JsonSerializable()
class Imprint {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'holder', required: true)
  final String holder;

  @JsonKey(name: 'street', required: true)
  final String street;

  @JsonKey(name: 'city', required: true)
  final String city;

  @JsonKey(name: 'phone', required: true)
  final String phone;

  @JsonKey(name: 'mail', required: true)
  final String mail;

  @JsonKey(name: 'tax', required: true)
  final String tax;

  @JsonKey(name: 'homepage', required: true)
  final String homepage;

  @JsonKey(name: 'companyname', required: true)
  final String companyName;

  Imprint({
    required this.id,
    required this.holder,
    required this.street,
    required this.city,
    required this.phone,
    required this.mail,
    required this.tax,
    required this.homepage,
    required this.companyName,
  });

  factory Imprint.fromJson(Map<String, dynamic> json) => _$ImprintFromJson(json);

  Map<String, dynamic> toJson() => _$ImprintToJson(this);
}
