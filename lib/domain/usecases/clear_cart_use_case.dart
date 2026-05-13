import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  ClearCartUseCase(this._repository);

  Either<Failure, Unit> execute(String tableId) {
    return _repository.clearCart(tableId);
  }
}
