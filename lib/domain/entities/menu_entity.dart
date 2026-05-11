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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MenuEntity && runtimeType == other.runtimeType &&
              id == other.id && name == other.name &&
              description == other.description && price == other.price &&
              categoryId == other.categoryId && imageUrl == other.imageUrl &&
              customizationGroups == other.customizationGroups;

  @override
  int get hashCode =>
      Object.hash(
          id,
          name,
          description,
          price,
          categoryId,
          imageUrl,
          customizationGroups);


}