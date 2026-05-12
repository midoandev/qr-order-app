import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/core/error/failure.dart';
import 'package:qrorder/domain/entities/menu_data_entity.dart';
import 'package:qrorder/domain/entities/restaurant_entity.dart';
import 'package:qrorder/domain/repositories/menu_repository.dart';
import 'package:qrorder/domain/usecases/get_menu_use_case.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

void main() {
  late GetMenuUseCase usecase;
  late MockMenuRepository mockMenuRepository;

  setUp(() {
    mockMenuRepository = MockMenuRepository();
    usecase = GetMenuUseCase(mockMenuRepository);
  });

  const tTableId = 'T001';
  const tMenuDataEntity = MenuDataEntity(
    restaurant: RestaurantEntity(id: 'R001', name: 'Sushi Zen', tableId: tTableId),
    categories: [],
    items: [],
  );

  test('must get data menu from repository when execution is successful', () async {
    // arrange
    when(() => mockMenuRepository.getMenuData(any()))
        .thenAnswer((_) async => const Right(tMenuDataEntity));

    // act
    final result = await usecase.execute(tTableId);

    // assert
    expect(result, const Right(tMenuDataEntity));
    verify(() => mockMenuRepository.getMenuData(tTableId)).called(1);
    verifyNoMoreInteractions(mockMenuRepository);
  });

  test('mest be return ServerFailure from repository when fail', () async {
    // arrange
    const tFailure = ServerFailure('Gagal mengambil data');
    when(() => mockMenuRepository.getMenuData(any()))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase.execute(tTableId);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockMenuRepository.getMenuData(tTableId)).called(1);
    verifyNoMoreInteractions(mockMenuRepository);
  });
}