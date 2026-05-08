import 'package:dartz/dartz.dart' hide Order;

import '../../core/networks/error/failure.dart';
import '../entities/order_entity.dart';
import '../entities/order_item_entity.dart';
import '../entities/order_request_entity.dart';
import '../repositories/order_repository.dart';

class SubmitOrderUseCase {
  final OrderRepository _repository;
  SubmitOrderUseCase(this._repository);


  Future<Either<Failure, OrderEntity>> execute({
    required String tableId,
    required List<OrderItemEntity> items,
    String? customerNote,
  }) async {
    final request = OrderRequestEntity(
      tableId: tableId,
      customerNote: customerNote,
      items: items,
    );

    return await _repository.submitOrder(request);
  }
}
