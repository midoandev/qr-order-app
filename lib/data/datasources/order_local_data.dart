import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_model.dart';

abstract class OrderLocalData {
  Future<OrderModel> saveOrder(OrderModel order);

  Future<List<OrderModel>> getAllActiveOrders();
}

class OrderLocalDataImpl implements OrderLocalData {
  final SharedPreferences prefs;
  static const _ordersKey = 'persistent_orders';

  OrderLocalDataImpl(this.prefs);

  @override
  Future<OrderModel> saveOrder(OrderModel order) async {
    try {
      final List<String> currentOrdersRaw =
          prefs.getStringList(_ordersKey) ?? [];

      // Ambil Map murni
      final Map<String, dynamic> orderMap = order.toJson();

      // Encode ke JSON String
      final String orderJson = jsonEncode(orderMap);

      currentOrdersRaw.add(orderJson);
      await prefs.setStringList(_ordersKey, currentOrdersRaw);
      return order;
    } catch (e) {
      throw Exception("Format data order tidak didukung untuk penyimpanan: $e");
    }
  }

  @override
  Future<List<OrderModel>> getAllActiveOrders() async {
    final List<String> currentOrdersRaw = prefs.getStringList(_ordersKey) ?? [];

    return currentOrdersRaw.map((e) {
      final Map<String, dynamic> decoded =
          jsonDecode(e) as Map<String, dynamic>;
      return OrderModel.fromJson(decoded);
    }).toList();
  }
}
