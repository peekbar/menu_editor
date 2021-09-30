import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'name', required: true)
  final String name;

  @JsonKey(name: 'shortname', required: true)
  final String shortName;

  @JsonKey(name: 'description', required: true)
  final String description;

  @JsonKey(name: 'price', required: true)
  final String price;

  @JsonKey(name: 'additives', required: true)
  final String additives;

  Product({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.price,
    required this.additives,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copy() => Product(
        id: const Uuid().v4(),
        name: name,
        shortName: shortName,
        description: description,
        price: price,
        additives: additives,
      );
}
