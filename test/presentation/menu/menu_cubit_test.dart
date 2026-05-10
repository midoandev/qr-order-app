import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/core/networks/error/failure.dart';
import 'package:qrorder/domain/entities/menu_data_entity.dart';
import 'package:qrorder/domain/entities/restaurant_entity.dart';
import 'package:qrorder/domain/entities/category_entity.dart';
import 'package:qrorder/domain/usecases/get_menu_use_case.dart';
import 'package:qrorder/presentation/menu/cubits/menu_cubit.dart';
import 'package:qrorder/presentation/menu/cubits/menu_state.dart';

class MockGetMenuUseCase extends Mock implements GetMenuUseCase {}

void main() {
  late MenuCubit cubit;
  late MockGetMenuUseCase mockGetMenuUseCase;

  setUp(() {
    mockGetMenuUseCase = MockGetMenuUseCase();
    cubit = MenuCubit(mockGetMenuUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  const tTableId = 'T001';
  const tMenuDataEntity = MenuDataEntity(
    restaurant: RestaurantEntity(
      id: 'R001',
      name: 'Sushi Zen',
      tableId: tTableId,
    ),
    categories: [CategoryEntity(id: 1, name: 'Main', sortOrder: 1)],
    items: [],
  );

  test('first state should be MenuInitial', () {
    expect(cubit.state, equals(MenuInitial()));
  });

  blocTest<MenuCubit, MenuState>(
    'should emit [MenuLoading, MenuLoaded] when data is successfully fetched and not empty',
    build: () {
      when(
        () => mockGetMenuUseCase.execute(any()),
      ).thenAnswer((_) async => const Right(tMenuDataEntity));
      return cubit;
    },
    act: (cubit) => cubit.fetchMenu(tTableId),
    expect: () => [MenuLoading(), const MenuLoaded(tMenuDataEntity)],
    verify: (_) {
      verify(() => mockGetMenuUseCase.execute(tTableId)).called(1);
    },
  );

  blocTest<MenuCubit, MenuState>(
    'harus emit [MenuLoading, MenuLoaded] ketika data berhasil diambil dan tidak kosong',
    build: () {
      when(() => mockGetMenuUseCase.execute(any()))
          .thenAnswer((_) async => const Right(tMenuDataEntity));
      return cubit;
    },
    act: (cubit) => cubit.fetchMenu(tTableId),
    expect: () => [
      MenuLoading(),
      const MenuLoaded(tMenuDataEntity),
    ],
    verify: (_) {
      verify(() => mockGetMenuUseCase.execute(tTableId)).called(1);
    },
  );

  blocTest<MenuCubit, MenuState>(
    'should emit [MenuLoading, MenuEmpty] when category data is empty',
    build: () {
      const emptyMenuData = MenuDataEntity(
        restaurant: RestaurantEntity(
          id: 'R001',
          name: 'Sushi Zen',
          tableId: tTableId,
        ),
        categories: [],
        items: [],
      );
      when(
        () => mockGetMenuUseCase.execute(any()),
      ).thenAnswer((_) async => const Right(emptyMenuData));
      return cubit;
    },
    act: (cubit) => cubit.fetchMenu(tTableId),
    expect: () => [MenuLoading(), MenuEmpty()],
  );

  blocTest<MenuCubit, MenuState>(
    'should emit [MenuLoading, MenuError] when fetching fails',
    build: () {
      when(
        () => mockGetMenuUseCase.execute(any()),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      return cubit;
    },
    act: (cubit) => cubit.fetchMenu(tTableId),
    expect: () => [MenuLoading(), const MenuError('Server Error')],
  );
}
