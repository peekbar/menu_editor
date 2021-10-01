import 'package:json_annotation/json_annotation.dart';
import 'package:menu_editor/models/food_category.dart';
import 'package:menu_editor/models/imprint.dart';
import 'package:menu_editor/models/info_banner.dart';
import 'package:menu_editor/models/language.dart';
import 'package:menu_editor/models/minimum_order.dart';
import 'package:menu_editor/models/opening_hours.dart';
import 'package:uuid/uuid.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'editedAt', required: true)
  final DateTime editedAt;

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(name: 'language', required: true)
  final Language language;

  @JsonKey(name: 'categories', required: true)
  final List<FoodCategory> categories;

  @JsonKey(name: 'banners', required: true)
  final List<InfoBanner> banners;

  @JsonKey(name: 'opening_hours', required: true)
  final List<OpeningHours> openingHours;

  @JsonKey(name: 'min_order', required: true)
  final List<MinimumOrder> minimumOrders;

  @JsonKey(name: 'imprint', required: true)
  final Imprint imprint;

  Menu({
    required this.id,
    required this.editedAt,
    required this.title,
    required this.language,
    required this.categories,
    required this.banners,
    required this.openingHours,
    required this.minimumOrders,
    required this.imprint,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  Menu copy() => Menu(
        id: const Uuid().v4(),
        editedAt: DateTime.now(),
        title: title,
        language: language,
        categories: categories.toList(),
        banners: banners.toList(),
        openingHours: openingHours.toList(),
        minimumOrders: minimumOrders.toList(),
        imprint: imprint,
      );
}
