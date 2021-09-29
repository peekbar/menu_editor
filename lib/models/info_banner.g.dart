// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoBanner _$InfoBannerFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'title', 'text'],
  );
  return InfoBanner(
    id: json['id'] as String,
    title: json['title'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$InfoBannerToJson(InfoBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
    };
