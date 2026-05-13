import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/domain/usecases/get_active_orders_use_case.dart';
import 'package:qrorder/presentation/home/cubits/home_cubit.dart';
import 'package:qrorder/presentation/home/cubits/home_state.dart';

class MockGetActiveOrdersUseCase extends Mock implements GetActiveOrdersUseCase {}

void main() {
  late MockGetActiveOrdersUseCase mockUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    mockUseCase = MockGetActiveOrdersUseCase();
    homeCubit = HomeCubit(mockUseCase);
  });

  blocTest<HomeCubit, HomeState>(
    'emits [isLoading: true, orders: [...]] when loadOngoingOrders is successful',
    build: () {
      when(() => mockUseCase.execute()).thenAnswer((_) async => const Right([]));
      return homeCubit;
    },
    act: (cubit) => cubit.loadOngoingOrders(),
    expect: () => [
      const HomeState(isLoading: true),
      const HomeState(isLoading: false, orders: []),
    ],
  );
}