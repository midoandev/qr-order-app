import '../../domain/entities/customization_group_entity.dart';
import 'customization_option_model.dart';

class CustomizationGroupModel {
  final int id;
  final String name;
  final bool isRequired;
  final int maxSelections;
  final List<CustomizationOptionModel> options;

  CustomizationGroupModel({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.maxSelections,
    required this.options,
  });

  factory CustomizationGroupModel.fromJson(Map<String, dynamic> json) {
    return CustomizationGroupModel(
      id: json['id'] as int,
      name: json['name'] as String,
      isRequired: json.containsKey('is_required') ? json['is_required'] as bool : false,
      maxSelections: (json['max_selections']),
      options: (json['options'] as List)
          .map((e) => CustomizationOptionModel.fromJson(e))
          .toList(),
    );
  }

  CustomizationGroupEntity toEntity() {
    return CustomizationGroupEntity(
      id: id,
      name: name,
      isRequired: isRequired,
      maxSelections: maxSelections,
      options: options.map((e) => e.toEntity()).toList(),
    );
  }

  factory CustomizationGroupModel.fromEntity(CustomizationGroupEntity entity) {
    return CustomizationGroupModel(
      id: entity.id,
      name: entity.name,
      isRequired: entity.isRequired,
      maxSelections: entity.maxSelections,
      options: entity.options
          .map((e) => CustomizationOptionModel.fromEntity(e))
          .toList(),
    );
  }
}
