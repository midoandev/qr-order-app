import 'package:dartz/dartz.dart';
import '../../core/networks/error/failure.dart';
import '../entities/cart_entity.dart';
import '../entities/customization_option_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateItemDetailsUseCase {
  final CartRepository _repository;

  UpdateItemDetailsUseCase(this._repository);

  Future<Either<Failure, CartEntity>> execute({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionEntity> selections,
    String? notes,
  }) async {
    return await _repository.updateItemDetails(
      tableId: tableId,
      cartItemId: cartItemId,
      selections: selections,
      notes: notes,
    );
  }
}