import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'minimum_order.g.dart';

@JsonSerializable()
class MinimumOrder {
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'dist', required: true)
  final String distance;

  @JsonKey(name: 'order', required: true)
  final String order;

  MinimumOrder({required this.id, required this.distance, required this.order});

  factory MinimumOrder.fromJson(Map<String, dynamic> json) => _$MinimumOrderFromJson(json);

  Map<String, dynamic> toJson() => _$MinimumOrderToJson(this);

  MinimumOrder copy() => MinimumOrder(id: const Uuid().v4(), distance: distance, order: order);
}
