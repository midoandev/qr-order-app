import 'package:dartz/dartz.dart';
import '../../core/networks/error/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _repository;

  GetCartUseCase(this._repository);

  Future<Either<Failure, CartEntity>> execute(String tableId) async {
    return await _repository.getCart(tableId);
  }
}