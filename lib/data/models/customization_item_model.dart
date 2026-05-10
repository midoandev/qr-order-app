import '../../domain/entities/customization_item_entity.dart';

class CustomizationItemModel {
  final int optionId;
  int quantity;

  CustomizationItemModel({required this.optionId, required this.quantity});

  factory CustomizationItemModel.fromEntity(CustomizationItemEntity entity) {
    return CustomizationItemModel(
      optionId: entity.optionId,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
    "option_id": optionId,
    "quantity": quantity,
  };

  CustomizationItemEntity toEntity() {
    return CustomizationItemEntity(optionId: optionId, quantity: quantity);
  }
}
