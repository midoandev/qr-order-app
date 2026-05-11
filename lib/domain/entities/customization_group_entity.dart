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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomizationGroupEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          isRequired == other.isRequired &&
          maxSelections == other.maxSelections &&
          options == other.options;

  @override
  int get hashCode => Object.hash(id, name, isRequired, maxSelections, options);
}