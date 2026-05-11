import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/customization_option_entity.dart';
import '../../core/networks/error/failure.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart(String tableId);

  Future<Either<Failure, CartEntity>> addToCart(
    String tableId,
    CartItemEntity item,
  );

  Future<Either<Failure, CartEntity>> updateQuantity(
    String tableId,
    String itemId,
    int newQuantity,
  );

  Future<Either<Failure, CartEntity>> updateItemDetails({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionEntity> selections,
    String? notes,
  });
}
