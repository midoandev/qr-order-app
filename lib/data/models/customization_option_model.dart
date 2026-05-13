import '../../domain/entities/customization_option_entity.dart';

class CustomizationOptionModel {
  final int id;
  final String name;
  final double priceModifier;

  CustomizationOptionModel({
    required this.id,
    required this.name,
    required this.priceModifier,
  });


  factory CustomizationOptionModel.fromJson(Map<String, dynamic> json) {
    return CustomizationOptionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      priceModifier: (json['price_modifier'] as num).toDouble(),
    );
  }

  CustomizationOptionEntity toEntity() {
    return CustomizationOptionEntity(
      id: id,
      name: name,
      priceModifier: priceModifier,
    );
  }


  factory CustomizationOptionModel.fromEntity(CustomizationOptionEntity entity) {
    return CustomizationOptionModel(
      id: entity.id,
      name: entity.name,
      priceModifier: entity.priceModifier,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price_modifier': priceModifier,
    };
  }
}