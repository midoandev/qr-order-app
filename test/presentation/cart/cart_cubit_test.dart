import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/core/error/failure.dart';
import 'package:qrorder/domain/entities/cart_entity.dart';
import 'package:qrorder/domain/usecases/add_to_cart_use_case.dart';
import 'package:qrorder/domain/usecases/get_cart_use_case.dart';
import 'package:qrorder/domain/usecases/update_cart_quantity_use_case.dart';
import 'package:qrorder/domain/usecases/update_item_details_use_case.dart';
import 'package:qrorder/presentation/cart/cubits/cart_cubit.dart';
import 'package:qrorder/presentation/cart/cubits/cart_state.dart';

class MockGetCartUseCase extends Mock implements GetCartUseCase {}

class MockAddToCartUseCase extends Mock implements AddToCartUseCase {}

class MockUpdateCartQuantityUseCase extends Mock
    implements UpdateCartQuantityUseCase {}

class MockUpdateItemDetailsUseCase extends Mock
    implements UpdateItemDetailsUseCase {}

void main() {
  late CartCubit cubit;
  late MockGetCartUseCase mockGetCart;
  late MockAddToCartUseCase mockAddToCart;
  late MockUpdateCartQuantityUseCase mockUpdateQty;
  late MockUpdateItemDetailsUseCase mockUpdateItemDetails;

  setUp(() {
    mockGetCart = MockGetCartUseCase();
    mockAddToCart = MockAddToCartUseCase();
    mockUpdateQty = MockUpdateCartQuantityUseCase();
    mockUpdateItemDetails = MockUpdateItemDetailsUseCase();
    cubit = CartCubit(
      mockGetCart,
      mockAddToCart,
      mockUpdateQty,
      mockUpdateItemDetails,
    );
  });

  const tTableId = 'T001';
  const tCart = CartEntity(tableId: tTableId, items: []);

  blocTest<CartCubit, CartState>(
    'should emit [CartLoading, CartEmpty] when fetch is successful but the cart is empty',
    build: () {
      when(
        () => mockGetCart.execute(any()),
      ).thenAnswer((_) async => const Right(tCart));
      return cubit;
    },
    act: (cubit) => cubit.fetchCart(tTableId),
    expect: () => [CartLoading(), CartEmpty()],
  );

  blocTest<CartCubit, CartState>(
    'should emit [CartError] when fetching fails',
    build: () {
      when(
        () => mockGetCart.execute(any()),
      ).thenAnswer((_) async => const Left(ServerFailure('Error')));
      return cubit;
    },
    act: (cubit) => cubit.fetchCart(tTableId),
    expect: () => [CartLoading(), const CartError(message: 'Error')],
  );
}
