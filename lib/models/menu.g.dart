// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'editedAt',
      'title',
      'language',
      'categories',
      'banners',
      'opening_hours',
      'min_order',
      'imprint'
    ],
  );
  return Menu(
    id: json['id'] as String,
    editedAt: DateTime.parse(json['editedAt'] as String),
    title: json['title'] as String,
    language: _$enumDecode(_$LanguageEnumMap, json['language']),
    categories: (json['categories'] as List<dynamic>)
        .map((e) => FoodCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
    banners: (json['banners'] as List<dynamic>)
        .map((e) => InfoBanner.fromJson(e as Map<String, dynamic>))
        .toList(),
    openingHours: (json['opening_hours'] as List<dynamic>)
        .map((e) => OpeningHours.fromJson(e as Map<String, dynamic>))
        .toList(),
    minimumOrders: (json['min_order'] as List<dynamic>)
        .map((e) => MinimumOrder.fromJson(e as Map<String, dynamic>))
        .toList(),
    imprint: Imprint.fromJson(json['imprint'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'editedAt': instance.editedAt.toIso8601String(),
      'title': instance.title,
      'language': _$LanguageEnumMap[instance.language],
      'categories': instance.categories,
      'banners': instance.banners,
      'opening_hours': instance.openingHours,
      'min_order': instance.minimumOrders,
      'imprint': instance.imprint,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$LanguageEnumMap = {
  Language.de: 'DE',
  Language.en: 'EN',
};
