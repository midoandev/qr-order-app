import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrorder/domain/entities/customization_option_entity.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/usecases/add_to_cart_use_case.dart';
import '../../../domain/usecases/get_cart_use_case.dart';
import '../../../domain/usecases/update_cart_quantity_use_case.dart';
import '../../../domain/usecases/update_item_details_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartQuantityUseCase _updateCartQuantityUseCase;
  final UpdateItemDetailsUseCase _updateItemDetailsUseCase;

  CartCubit(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._updateCartQuantityUseCase,
    this._updateItemDetailsUseCase,
  ) : super(CartInitial());

  Future<void> fetchCart(String tableId) async {
    emit(CartLoading());
    final result = await _getCartUseCase.execute(tableId);

    result.fold((failure) => emit(CartError(message: failure.message)), (cart) {
      if (cart.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart: cart));
      }
    });
  }

  Future<void> addItem(String tableId, CartItemEntity item) async {
    if (state is! CartLoaded) emit(CartLoading());

    final result = await _addToCartUseCase.execute(tableId, item);

    result.fold(
      (failure) => emit(CartError(message: failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> updateQuantity(
    String tableId,
    String itemId,
    int newQuantity,
  ) async {
    final result = await _updateCartQuantityUseCase.execute(
      tableId,
      itemId,
      newQuantity,
    );

    result.fold((failure) => emit(CartError(message: failure.message)), (cart) {
      if (cart.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart: cart));
      }
    });
  }

  Future<void> updateItemDetails({
    required String tableId,
    required String cartItemId,
    required List<CustomizationOptionEntity> selections,
    String? notes,
  }) async {
    final result = await _updateItemDetailsUseCase.execute(
      tableId: tableId,
      cartItemId: cartItemId,
      selections: selections,
      notes: notes,
    );

    result.fold((failure) => emit(CartError(message: failure.message)), (cart) {
      if (cart.items.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartLoaded(cart: cart));
      }
    });
  }
}
