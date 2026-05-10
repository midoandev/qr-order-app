import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final int sortOrder;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      sortOrder: entity.sortOrder,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, sortOrder: sortOrder);
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "sort_order": sortOrder,
    };
  }
}
