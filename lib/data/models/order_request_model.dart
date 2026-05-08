import '../../domain/entities/order_request_entity.dart';
import 'order_item_model.dart';

class OrderRequestModel extends OrderRequestEntity {
  OrderRequestModel({
    required super.tableId,
    required super.items,
    super.customerNote,
  });


  factory OrderRequestModel.fromEntity(OrderRequestEntity entity) {
    return OrderRequestModel(
      tableId: entity.tableId,
      items: entity.items,
      customerNote: entity.customerNote,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "table_id": tableId,
      "items": items.map((e) => OrderItemModel.fromEntity(e).toJson()).toList(),
      "customer_note": customerNote,
    };
  }
}