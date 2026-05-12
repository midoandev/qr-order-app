import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/cart_item_entity.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class CheckoutUseCase {
  final OrderRepository _repository;

  CheckoutUseCase(this._repository);

  Future<Either<Failure, OrderEntity>> execute({
    required String tableId,
    required List<CartItemEntity> cartItems,
  }) async {
    return await _repository.checkout(tableId: tableId, cartItems: cartItems);
  }
}
