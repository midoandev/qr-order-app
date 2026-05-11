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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuDataEntity &&
          runtimeType == other.runtimeType &&
          restaurant == other.restaurant &&
          categories == other.categories &&
          items == other.items;

  @override
  int get hashCode => Object.hash(restaurant, categories, items);
}