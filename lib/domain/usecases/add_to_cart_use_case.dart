import 'package:dartz/dartz.dart';
import '../../core/networks/error/failure.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> execute(String tableId, CartItemEntity item) async {
    if (item.quantity <= 0) {
      return const Left(ValidationFailure("Quantity should bigger than 0"));
    }
    return await _repository.addToCart(tableId, item);
  }
}