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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemEntity &&
          runtimeType == other.runtimeType &&
          menuItemId == other.menuItemId &&
          quantity == other.quantity &&
          customizations == other.customizations;

  @override
  int get hashCode => Object.hash(menuItemId, quantity, customizations);
}
