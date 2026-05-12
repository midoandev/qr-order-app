import 'cart_item_entity.dart';

class OrderEntity {
  final String id;
  final String tableId;
  final List<CartItemEntity> items;
  final double totalPrice;
  final DateTime createdAt;
  final String status; // e.g., "pending", "processing", "completed"

  const OrderEntity({
    required this.id,
    required this.tableId,
    required this.items,
    required this.totalPrice,
    required this.createdAt,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tableId == other.tableId &&
          items == other.items &&
          totalPrice == other.totalPrice &&
          createdAt == other.createdAt &&
          status == other.status;

  @override
  int get hashCode =>
      Object.hash(id, tableId, items, totalPrice, createdAt, status);
}
