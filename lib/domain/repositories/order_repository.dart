import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/order_entity.dart';
import 'package:qrorder/domain/entities/order_request_entity.dart';

import '../../core/networks/error/failure.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> submitOrder(OrderRequestEntity payload);

  Future<Either<Failure, OrderEntity>> getOrderStatus(int orderId);

}
