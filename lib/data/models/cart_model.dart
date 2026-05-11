import '../../domain/entities/cart_entity.dart';
import 'cart_item_model.dart';

class CartModel {
  final String tableId;
  final List<CartItemModel> items;

  const CartModel({required this.tableId, required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      tableId: json['table_id'] as String,
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      tableId: entity.tableId,
      items: entity.items.map((e) => CartItemModel.fromEntity(e)).toList(),
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      tableId: tableId,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}
