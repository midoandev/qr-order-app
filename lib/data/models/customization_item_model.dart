import '../../domain/entities/customization_item_entity.dart';

class CustomizationItemModel extends CustomizationItemEntity {
  CustomizationItemModel({required super.optionId, required super.quantity});

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
}
