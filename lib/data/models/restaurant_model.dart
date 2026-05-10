import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String tableId;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.tableId,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      tableId: json['table_id'] as String,
    );
  }

  factory RestaurantModel.fromEntity(RestaurantEntity entity) {
    return RestaurantModel(
      id: entity.id,
      name: entity.name,
      tableId: entity.tableId,
    );
  }

  RestaurantEntity toEntity() {
    return RestaurantEntity(
      id: id,
      name: name,
      tableId: tableId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": tableId,
      "name": name,
      "table_id": tableId,
    };
  }
}