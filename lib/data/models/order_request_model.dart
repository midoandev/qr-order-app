import '../../domain/entities/order_request_entity.dart';
import 'order_item_model.dart';

class OrderRequestModel {
  final String tableId;
  final List<OrderItemModel> items;
  final String? customerNote;
  OrderRequestModel({
    required this.tableId,
    required this.items,
    this.customerNote,
  });


  factory OrderRequestModel.fromEntity(OrderRequestEntity entity) {
    return OrderRequestModel(
      tableId: entity.tableId,
      items: entity.items.map((e) => OrderItemModel.fromEntity(e)).toList(),
      customerNote: entity.customerNote,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "table_id": tableId,
      "items": items.map((e) => e.toJson()).toList(),
      "customer_note": customerNote,
    };
  }
}