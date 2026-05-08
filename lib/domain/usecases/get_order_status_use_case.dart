import 'package:dartz/dartz.dart';

import '../../core/networks/error/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderStatusUseCase {
  final OrderRepository _repository;

  GetOrderStatusUseCase(this._repository);

  Future<Either<Failure, OrderEntity>> execute(int orderId) async {
    return await _repository.getOrderStatus(orderId);
  }
}