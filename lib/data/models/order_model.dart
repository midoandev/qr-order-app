import 'package:qrorder/domain/entities/order_entity.dart';

class OrderModel {
  final int id;
  final String tableId;
  final String status;
  final double totalPrice;
  final String? customerNote;
  final String? estimatedTime;

  OrderModel({
    required this.id,
    required this.tableId,
    required this.status,
    required this.totalPrice,
    this.customerNote,
    this.estimatedTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      tableId: json['table_id'] as String,
      status: json['status'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      customerNote: json['customer_note'] as String?,
      estimatedTime: json['estimated_time'] as String?,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      tableId: tableId,
      status: status,
      totalPrice: totalPrice,
      customerNote: customerNote,
      estimatedTime: estimatedTime,
    );
  }
}