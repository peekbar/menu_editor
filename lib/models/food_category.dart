import 'package:json_annotation/json_annotation.dart';
import 'package:menu_editor/models/product.dart';
import 'package:uuid/uuid.dart';

part 'food_category.g.dart';

@JsonSerializable()
class FoodCategory {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'name', required: true)
   String name;

  @JsonKey(name: 'icon', required: true)
   String icon;

  @JsonKey(name: 'products', required: true)
  final List<Product> products;

  FoodCategory({required this.id, required this.name, required this.icon, required this.products});

  factory FoodCategory.fromJson(Map<String, dynamic> json) => _$FoodCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);

  FoodCategory copy() => FoodCategory(
        id: const Uuid().v4(),
        name: name,
        icon: icon,
        products: products.map((p) => p.copy()).toList(),
      );
}
