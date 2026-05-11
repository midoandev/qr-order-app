import 'cart_item_entity.dart';

class CartEntity {
  final String tableId;
  final List<CartItemEntity> items;

  const CartEntity({
    required this.tableId,
    required this.items,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.11; // Contoh pajak 11%
  double get grandTotal => subtotal + tax;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartEntity && runtimeType == other.runtimeType &&
              tableId == other.tableId && items == other.items;

  @override
  int get hashCode => Object.hash(tableId, items);


}