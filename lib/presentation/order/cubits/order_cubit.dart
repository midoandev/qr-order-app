import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/usecases/checkout_use_case.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final CheckoutUseCase _checkoutUseCase;

  OrderCubit(this._checkoutUseCase) : super(OrderInitial());

  Future<void> submitOrder({
    required String tableId,
    required List<CartItemEntity> cartItems,
  }) async {
    emit(OrderLoading());

    final result = await _checkoutUseCase.execute(
      tableId: tableId,
      cartItems: cartItems,
    );

    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderLoaded(order)),
    );
  }
}
