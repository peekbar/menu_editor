import 'package:json_annotation/json_annotation.dart';

enum Language {
  @JsonValue('DE')
  de,
  @JsonValue('EN')
  en,
}
