import 'package:qrorder/data/models/customization_option_model.dart';

import '../models/cart_model.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalData {
  Future<CartModel> getCart(String tableId);

  Future<CartModel> addToCart(String tableId, CartItemModel item);

  Future<CartModel> updateQuantity(
    String tableId,
    String itemId,
    int newQuantity,
  );

  Future<CartModel> updateItemDetails({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionModel> selections,
    String? notes,
  });
}

class CartLocalDataImpl implements CartLocalData {
  final Map<String, CartModel> _database = {};

  @override
  Future<CartModel> getCart(String tableId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _database[tableId] ?? CartModel(tableId: tableId, items: const []);
  }

  @override
  Future<CartModel> addToCart(String tableId, CartItemModel item) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final currentCart =
        _database[tableId] ?? CartModel(tableId: tableId, items: const []);
    final currentItems = List<CartItemModel>.from(
      currentCart.items.map((e) => e),
    );

    final customizationKey =
        item.selectedCustomizations.map((e) => e.id).toList()..sort();
    final String compositeId =
        "${item.menuItem.id}_${customizationKey.join('-')}";

    final existingIndex = currentItems.indexWhere((element) {
      final elementCustomKey =
          element.selectedCustomizations.map((e) => e.id).toList()..sort();
      final String elementCompositeId =
          "${element.menuItem.id}_${elementCustomKey.join('-')}";
      return elementCompositeId == compositeId;
    });

    if (existingIndex >= 0) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = CartItemModel(
        id: existingItem.id,
        menuItem: existingItem.menuItem,
        quantity: existingItem.quantity + item.quantity,
        notes: item.notes ?? existingItem.notes,
        selectedCustomizations: existingItem.selectedCustomizations,
      );
    } else {
      currentItems.add(
        CartItemModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          // ID Baru
          menuItem: item.menuItem,
          quantity: item.quantity,
          notes: item.notes,
          selectedCustomizations: item.selectedCustomizations,
        ),
      );
    }

    final updatedCart = CartModel(tableId: tableId, items: currentItems);
    _database[tableId] = updatedCart;
    return updatedCart;
  }

  @override
  Future<CartModel> updateQuantity(
    String tableId,
    String itemId,
    int newQuantity,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final currentCart = _database[tableId];
    if (currentCart == null) throw Exception("Cart not found");

    final currentItems = List<CartItemModel>.from(
      currentCart.items.map((e) => e),
    );
    final itemIndex = currentItems.indexWhere(
      (element) => element.id == itemId,
    );

    if (itemIndex >= 0) {
      if (newQuantity <= 0) {
        currentItems.removeAt(itemIndex);
      } else {
        final item = currentItems[itemIndex];
        currentItems[itemIndex] = CartItemModel(
          id: item.id,
          menuItem: item.menuItem,
          quantity: newQuantity,
          notes: item.notes,
          selectedCustomizations: item.selectedCustomizations,
        );
      }
    }

    final updatedCart = CartModel(tableId: tableId, items: currentItems);
    _database[tableId] = updatedCart;
    return updatedCart;
  }

  @override
  Future<CartModel> updateItemDetails({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionModel> selections,
    String? notes,
  }) async {
    final cart = _database[tableId];
    if (cart == null) throw Exception("Cart not found");

    final items = List<CartItemModel>.from(cart.items.map((e) => e));
    final index = items.indexWhere((element) => element.id == cartItemId);
    if (index == -1) throw Exception("Item not found in cart");

    final targetItem = items[index];

    // 1. Generate Composite ID baru untuk hasil kustomisasi yang baru
    final newCustomKey = selections.map((e) => e.id).toList()..sort();
    final String newCompositeId =
        "${targetItem.menuItem.id}_${newCustomKey.join('-')}";

    // 2. Cek apakah ada item LAIN yang sudah memiliki Composite ID yang sama
    final existingMatchIndex = items.indexWhere((element) {
      final elementCustomKey =
          element.selectedCustomizations.map((e) => e.id).toList()..sort();
      final String elementCompositeId =
          "${element.menuItem.id}_${elementCustomKey.join('-')}";
      return elementCompositeId == newCompositeId && element.id != cartItemId;
    });

    if (existingMatchIndex != -1) {
      // Jika kustomisasi baru membuatnya sama dengan item lain, gabungkan quantity-nya
      final existingItem = items[existingMatchIndex];
      items[existingMatchIndex] = CartItemModel(
        id: existingItem.id,
        menuItem: existingItem.menuItem,
        quantity: existingItem.quantity + targetItem.quantity,
        notes: notes ?? existingItem.notes,
        selectedCustomizations: existingItem.selectedCustomizations,
      );
      items.removeAt(index); // Hapus baris item yang lama
    } else {
      // Jika tetap unik, perbarui data di baris tersebut
      items[index] = CartItemModel(
        id: targetItem.id,
        menuItem: targetItem.menuItem,
        quantity: targetItem.quantity,
        notes: notes,
        selectedCustomizations: selections,
      );
    }

    final updatedCart = CartModel(tableId: tableId, items: items);
    _database[tableId] = updatedCart;
    return updatedCart;
  }
}
