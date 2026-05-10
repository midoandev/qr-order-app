import 'customization_option_entity.dart';

class CustomizationGroupEntity {
  final int id;
  final String name;
  final bool isRequired;
  final int maxSelections;
  final List<CustomizationOptionEntity> options;

  CustomizationGroupEntity({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.maxSelections,
    required this.options,
  });
}