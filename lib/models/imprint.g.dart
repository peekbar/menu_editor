// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Imprint _$ImprintFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'holder',
      'street',
      'city',
      'phone',
      'mail',
      'tax',
      'homepage',
      'companyname'
    ],
  );
  return Imprint(
    id: json['id'] as String,
    holder: json['holder'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
    phone: json['phone'] as String,
    mail: json['mail'] as String,
    tax: json['tax'] as String,
    homepage: json['homepage'] as String,
    companyName: json['companyname'] as String,
  );
}

Map<String, dynamic> _$ImprintToJson(Imprint instance) => <String, dynamic>{
      'id': instance.id,
      'holder': instance.holder,
      'street': instance.street,
      'city': instance.city,
      'phone': instance.phone,
      'mail': instance.mail,
      'tax': instance.tax,
      'homepage': instance.homepage,
      'companyname': instance.companyName,
    };
