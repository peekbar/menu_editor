import 'package:json_annotation/json_annotation.dart';

part 'minimum_order.g.dart';

@JsonSerializable()
class MinimumOrder {
  @JsonKey(name: 'dist', required: true)
  final String distance;

  @JsonKey(name: 'order', required: true)
  final String order;

  MinimumOrder({required this.distance, required this.order});

  factory MinimumOrder.fromJson(Map<String, dynamic> json) => _$MinimumOrderFromJson(json);

  Map<String, dynamic> toJson() => _$MinimumOrderToJson(this);
}
