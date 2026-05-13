import 'package:qrorder/data/models/customization_option_model.dart';

import '../../domain/entities/cart_item_entity.dart';
import 'menu_model.dart';

class CartItemModel {
  final String id;
  final MenuModel menuItem;
  final int quantity;
  final String? notes;
  final List<CustomizationOptionModel> selectedCustomizations;

  const CartItemModel({
    required this.id,
    required this.menuItem,
    required this.quantity,
    this.notes,
    required this.selectedCustomizations,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      menuItem: MenuModel.fromJson(json['menu_item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      notes: json['notes'] as String?,
      selectedCustomizations: (json['options'] as List)
          .map((e) => CustomizationOptionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menu_item': menuItem.toJson(),
      'quantity': quantity,
      'notes': notes,
      'options': selectedCustomizations.map((e) => e.toJson()).toList(),
    };
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      menuItem: MenuModel.fromEntity(entity.menuItem),
      quantity: entity.quantity,
      notes: entity.notes,
      selectedCustomizations: entity.selectedCustomizations
          .map((e) => CustomizationOptionModel.fromEntity(e))
          .toList(),
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      menuItem: menuItem.toEntity(),
      quantity: quantity,
      notes: notes,
      selectedCustomizations: selectedCustomizations
          .map((e) => e.toEntity())
          .toList(),
    );
  }
}
