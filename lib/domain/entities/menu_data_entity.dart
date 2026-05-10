import 'menu_entity.dart';
import 'restaurant_entity.dart';
import 'category_entity.dart';

class MenuDataEntity {
  final RestaurantEntity restaurant;
  final List<CategoryEntity> categories;
  final List<MenuEntity> items;

  const MenuDataEntity({
    required this.restaurant,
    required this.categories,
    required this.items,
  });
}