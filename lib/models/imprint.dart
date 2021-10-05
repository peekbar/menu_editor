import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'imprint.g.dart';

@JsonSerializable()
class Imprint {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'holder', required: true)
   String holder;

  @JsonKey(name: 'street', required: true)
   String street;

  @JsonKey(name: 'city', required: true)
   String city;

  @JsonKey(name: 'phone', required: true)
   String phone;

  @JsonKey(name: 'mail', required: true)
   String mail;

  @JsonKey(name: 'tax', required: true)
   String tax;

  @JsonKey(name: 'homepage', required: true)
   String homepage;

  @JsonKey(name: 'companyname', required: true)
  String companyName;

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

  Imprint copy() => Imprint(
        id: const Uuid().v4(),
        holder: holder,
        street: street,
        city: city,
        phone: phone,
        mail: mail,
        tax: tax,
        homepage: homepage,
        companyName: companyName,
      );
}
