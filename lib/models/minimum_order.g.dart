// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minimum_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinimumOrder _$MinimumOrderFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['dist', 'order'],
  );
  return MinimumOrder(
    distance: json['dist'] as String,
    order: json['order'] as String,
  );
}

Map<String, dynamic> _$MinimumOrderToJson(MinimumOrder instance) =>
    <String, dynamic>{
      'dist': instance.distance,
      'order': instance.order,
    };
