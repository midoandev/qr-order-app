import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/cart_item_entity.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_data.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalData _localDataSource;

  OrderRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, OrderEntity>> checkout({
    required String tableId,
    required List<CartItemEntity> cartItems,
  }) async {
    try {
      final double totalPrice = cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

      final orderModel = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tableId: tableId,
        items: cartItems.map((item) => CartItemModel.fromEntity(item)).toList(),
        totalPrice: totalPrice,
        createdAt: DateTime.now(),
        status: "pending",
      );

      final result = await _localDataSource.saveOrder(orderModel);
      return Right(result.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory(
    String tableId,
  ) async {
    try {
      final models = await _localDataSource.getOrders(tableId);
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
