// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minimum_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinimumOrder _$MinimumOrderFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'dist', 'order'],
  );
  return MinimumOrder(
    id: json['id'] as String,
    distance: json['dist'] as String,
    order: json['order'] as String,
  );
}

Map<String, dynamic> _$MinimumOrderToJson(MinimumOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dist': instance.distance,
      'order': instance.order,
    };
