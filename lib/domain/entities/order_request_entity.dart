import 'order_item_entity.dart';

class OrderRequestEntity {
  final String tableId;
  final List<OrderItemEntity> items;
  final String? customerNote;

  OrderRequestEntity({
    required this.tableId,
    required this.items,
    this.customerNote,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderRequestEntity &&
          runtimeType == other.runtimeType &&
          tableId == other.tableId &&
          items == other.items &&
          customerNote == other.customerNote;

  @override
  int get hashCode => Object.hash(tableId, items, customerNote);
}
