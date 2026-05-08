import 'customization_item_entity.dart';

class OrderItemEntity {
  final int menuItemId;
  final int quantity;
  final List<CustomizationItemEntity>? customizations;

  OrderItemEntity({
    required this.menuItemId,
    required this.quantity,
    this.customizations,
  });
}
