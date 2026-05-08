import 'package:qrorder/data/models/customization_item_model.dart';

import '../../domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.menuItemId,
    required super.quantity,
    super.customizations,
  });

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      menuItemId: entity.menuItemId,
      quantity: entity.quantity,
      customizations: entity.customizations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "menu_item_id": menuItemId,
      "quantity": quantity,
      "customizations": customizations
          ?.map((e) => CustomizationItemModel.fromEntity(e).toJson())
          .toList(),
    };
  }
}
