import 'customization_option_entity.dart';
import 'menu_entity.dart';

class CartItemEntity {
  final String id;
  final MenuEntity menuItem;
  final int quantity;
  final String? notes;
  final List<CustomizationOptionEntity> selectedCustomizations;

  const CartItemEntity({
    required this.id,
    required this.menuItem,
    required this.quantity,
    this.notes,
    required this.selectedCustomizations,
  });
  double get unitPrice {
    final extra = selectedCustomizations.fold(0.0, (sum, opt) => sum + opt.priceModifier);
    return menuItem.price + extra;
  }

  double get totalPrice => unitPrice * quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartItemEntity && runtimeType == other.runtimeType &&
              id == other.id && menuItem == other.menuItem &&
              quantity == other.quantity && notes == other.notes &&
              selectedCustomizations == other.selectedCustomizations;

  @override
  int get hashCode =>
      Object.hash(id, menuItem, quantity, notes, selectedCustomizations);


}
