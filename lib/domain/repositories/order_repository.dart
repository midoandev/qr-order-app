import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/cart_item_entity.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> checkout({
    required String tableId,
    required List<CartItemEntity> cartItems,
  });

  Future<Either<Failure, List<OrderEntity>>> getActiveOrders();
}
