import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/core/error/failure.dart';
import 'package:qrorder/data/datasources/ordering_remote_data_source.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  late OrderingRemoteDataSource dataSource;
  late MockAssetBundle mockAssetBundle;

  setUp(() {
    mockAssetBundle = MockAssetBundle();
    dataSource = OrderingRemoteDataSourceImpl(mockAssetBundle);
  });

  const tTableId = 'T001';
  final tJsonString = json.encode({
    "restaurant": {"id": "R001", "name": "Sushi Zen", "table_id": "T001"},
    "categories": [],
    "items": [],
  });

  test(
    'should return MenuDataModel when JSON loading is successful and tableId matches',
    () async {
      // arrange
      when(
        () => mockAssetBundle.loadString(any()),
      ).thenAnswer((_) async => tJsonString);

      // act
      final result = await dataSource.getMenusByTable(tTableId);

      // assert
      verify(
        () => mockAssetBundle.loadString('assets/mock/menu.json'),
      ).called(1);
      expect(result.isRight(), true);
      result.fold((failure) => fail('should not fail'), (data) {
        expect(data.restaurant.id, 'R001');
        expect(data.restaurant.tableId, tTableId);
      });
    },
  );

  test(
    'should return ServerFailure when tableId does not match the JSON response',
    () async {
      // arrange
      when(
        () => mockAssetBundle.loadString(any()),
      ).thenAnswer((_) async => tJsonString);

      // act
      final result = await dataSource.getMenusByTable(
        'T999',
      ); // Table ID Berbeda

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('should fail table ID validation'),
      );
    },
  );

  test(
    'should return ServerFailure when an Exception occurs (e.g., JSON file not found)',
    () async {
      // arrange
      when(
        () => mockAssetBundle.loadString(any()),
      ).thenThrow(Exception('File not found'));

      // act
      final result = await dataSource.getMenusByTable(tTableId);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, contains('File not found')),
        (_) => fail('should fail with an Exception'),
      );
    },
  );
}
