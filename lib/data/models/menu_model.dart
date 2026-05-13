import '../../domain/entities/menu_entity.dart';
import 'customization_group_model.dart';

class MenuModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final String? imageUrl;
  final List<CustomizationGroupModel> customizationGroups;

  MenuModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl,
    required this.customizationGroups,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['category_id'] as int,
      imageUrl: json['image_url'] as String?,
      customizationGroups: (json['customization_groups'] as List)
          .map((e) => CustomizationGroupModel.fromJson(e))
          .toList(),
    );
  }

  factory MenuModel.fromEntity(MenuEntity entity) {
    return MenuModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      categoryId: entity.categoryId,
      imageUrl: entity.imageUrl,
      customizationGroups: entity.customizationGroups
          .map((e) => CustomizationGroupModel.fromEntity(e))
          .toList(),
    );
  }

  MenuEntity toEntity() {
    return MenuEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      categoryId: categoryId,
      imageUrl: imageUrl,
      customizationGroups: customizationGroups
          .map((e) => e.toEntity())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "category_id": categoryId,
      "image_url": imageUrl,
      "customization_groups": customizationGroups.map((e) => e.toJson()).toList(),
    };
  }
}
