import 'package:qrorder/data/models/customization_item_model.dart';

import '../../domain/entities/order_item_entity.dart';

class OrderItemModel {
  final int menuItemId;
  final int quantity;
  final List<CustomizationItemModel>? customizations;

  OrderItemModel({
    required this.menuItemId,
    required this.quantity,
    this.customizations,
  });

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      menuItemId: entity.menuItemId,
      quantity: entity.quantity,
      customizations: entity.customizations
          ?.map((e) => CustomizationItemModel.fromEntity(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "menu_item_id": menuItemId,
      "quantity": quantity,
      "customizations": customizations?.map((e) => e.toJson()).toList(),
    };
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      menuItemId: menuItemId,
      quantity: quantity,
      customizations: customizations?.map((e) => e.toEntity()).toList(),
    );
  }
}
