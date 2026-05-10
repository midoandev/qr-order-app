import 'customization_group_entity.dart';

class MenuEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final String? imageUrl;
  final List<CustomizationGroupEntity> customizationGroups;

  MenuEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl,
    required this.customizationGroups,
  });
}