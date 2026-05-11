import 'package:dartz/dartz.dart';
import '../../core/networks/error/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository _repository;

  UpdateCartQuantityUseCase(this._repository);

  Future<Either<Failure, CartEntity>> execute(String tableId, String itemId, int newQuantity) async {
    return await _repository.updateQuantity(tableId, itemId, newQuantity);
  }
}