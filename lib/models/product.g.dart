// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'shortname',
      'description',
      'price',
      'additives'
    ],
  );
  return Product(
    id: json['id'] as String,
    name: json['name'] as String,
    shortName: json['shortname'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    additives: json['additives'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortname': instance.shortName,
      'description': instance.description,
      'price': instance.price,
      'additives': instance.additives,
    };
