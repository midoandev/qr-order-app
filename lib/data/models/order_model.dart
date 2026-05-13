import 'package:qrorder/domain/entities/order_entity.dart';

import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String tableId;
  final String status;
  final List<CartItemModel> items;
  final double totalPrice;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.tableId,
    required this.status,
    required this.totalPrice,
    required this.items,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      tableId: json['table_id'] as String,
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      tableId: tableId,
      status: status,
      totalPrice: totalPrice,
      createdAt: createdAt,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'table_id': tableId,
      'items': items.map((e) => e.toJson()).toList(),
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
