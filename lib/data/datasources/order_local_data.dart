import '../models/order_model.dart';

abstract class OrderLocalData {
  Future<OrderModel> saveOrder(OrderModel order);
  Future<List<OrderModel>> getOrders(String tableId);
}

class OrderLocalDataImpl implements OrderLocalData {
  final List<OrderModel> _orders = [];

  @override
  Future<OrderModel> saveOrder(OrderModel order) async {
    _orders.add(order);
    return order;
  }

  @override
  Future<List<OrderModel>> getOrders(String tableId) async {
    return _orders.where((e) => e.tableId == tableId).toList();
  }
}