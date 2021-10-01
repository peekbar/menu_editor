import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'info_banner.g.dart';

@JsonSerializable()
class InfoBanner {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(name: 'text', required: true)
  final String text;

  InfoBanner({required this.id, required this.title, required this.text});

  factory InfoBanner.fromJson(Map<String, dynamic> json) => _$InfoBannerFromJson(json);

  Map<String, dynamic> toJson() => _$InfoBannerToJson(this);

  InfoBanner copy() => InfoBanner(id: const Uuid().v4(), title: title, text: text);
}
