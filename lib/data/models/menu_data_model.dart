import '../../domain/entities/menu_data_entity.dart';
import 'menu_model.dart';
import 'restaurant_model.dart';
import 'category_model.dart';

class MenuDataModel {
  final RestaurantModel restaurant;
  final List<CategoryModel> categories;
  final List<MenuModel> items;

  const MenuDataModel({
    required this.restaurant,
    required this.categories,
    required this.items,
  });

  factory MenuDataModel.fromJson(Map<String, dynamic> json) {
    return MenuDataModel(
      restaurant: RestaurantModel.fromJson(json['restaurant']),
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      items: (json['items'] as List).map((e) => MenuModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant.toJson(),
      'categories': categories.map((e) => e.toJson()),
      'items': items.map((e) => e.toJson()),
    };
  }

  factory MenuDataModel.fromEntity(MenuDataEntity entity) {
    return MenuDataModel(
      restaurant: RestaurantModel.fromEntity(entity.restaurant),
      categories: entity.categories
          .map((e) => CategoryModel.fromEntity(e))
          .toList(),
      items: entity.items.map((e) => MenuModel.fromEntity(e)).toList(),
    );
  }

  MenuDataEntity toEntity() {
    return MenuDataEntity(
      restaurant: restaurant.toEntity(),
      categories: categories.map((e) => e.toEntity()).toList(),
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}
