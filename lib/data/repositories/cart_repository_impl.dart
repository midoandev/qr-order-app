import 'package:dartz/dartz.dart';
import '../../core/networks/error/failure.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/customization_option_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data.dart';
import '../models/cart_item_model.dart';
import '../models/customization_option_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalData _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, CartEntity>> getCart(String tableId) async {
    try {
      final cartModel = await _localDataSource.getCart(tableId);
      return Right(cartModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addToCart(String tableId, CartItemEntity item) async {
    try {
      final cartModel = await _localDataSource.addToCart(
        tableId,
        CartItemModel.fromEntity(item),
      );
      return Right(cartModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateQuantity(String tableId, String itemId, int newQuantity) async {
    try {
      final cartModel = await _localDataSource.updateQuantity(tableId, itemId, newQuantity);
      return Right(cartModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemDetails({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionEntity> selections,
    String? notes,
  }) async {
    try {
      final cartModel = await _localDataSource.updateItemDetails(
        tableId: tableId,
        cartItemId: cartItemId,
        selections: selections.map((e) => CustomizationOptionModel.fromEntity(e)).toList(),
        notes: notes,
      );
      return Right(cartModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}