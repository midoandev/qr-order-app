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
}
