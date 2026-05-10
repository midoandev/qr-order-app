import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/core/networks/error/failure.dart';
import 'package:qrorder/data/datasources/ordering_remote_data_source.dart';
import 'package:qrorder/data/models/menu_data_model.dart';
import 'package:qrorder/data/models/restaurant_model.dart';
import 'package:qrorder/data/repositories/menu_repository_impl.dart';
import 'package:qrorder/domain/entities/menu_data_entity.dart';

class MockOrderingRemoteDataSource extends Mock
    implements OrderingRemoteDataSource {}

void main() {
  late MenuRepositoryImpl repository;
  late MockOrderingRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockOrderingRemoteDataSource();
    repository = MenuRepositoryImpl(mockRemoteDataSource);
  });

  const tTableId = 'T001';
  const tMenuDataModel = MenuDataModel(
    restaurant: RestaurantModel(
      id: 'R001',
      name: 'Sushi Zen',
      tableId: tTableId,
    ),
    categories: [],
    items: [],
  );

  test(
    'should return MenuDataEntity when the call to remote data source is successful',
    () async {
      // arrange
      when(
        () => mockRemoteDataSource.getMenusByTable(any()),
      ).thenAnswer((_) async => const Right(tMenuDataModel));

      // act
      final result = await repository.getMenuData(tTableId);

      // assert
      verify(() => mockRemoteDataSource.getMenusByTable(tTableId)).called(1);
      expect(result.isRight(), true);

      // Verifikasi bahwa tipe yang dikembalikan adalah Entity, bukan Model
      result.fold(
        (failure) => fail('should get data successfully'),
        (data) => expect(data, isA<MenuDataEntity>()),
      );
    },
  );

  test(
    'should return ServerFailure when the call to remote data source fails',
    () async {
      // arrange
      const tFailure = ServerFailure('should throw a server error');
      when(
        () => mockRemoteDataSource.getMenusByTable(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await repository.getMenuData(tTableId);

      // assert
      verify(() => mockRemoteDataSource.getMenusByTable(tTableId)).called(1);
      expect(result, const Left(tFailure));
    },
  );
}
