import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/data/datasources/cart_local_data.dart';
import 'package:qrorder/data/models/cart_model.dart';
import 'package:qrorder/data/repositories/cart_repository_impl.dart';
import 'package:qrorder/domain/entities/cart_entity.dart';

class MockCartLocalData extends Mock implements CartLocalData {}

void main() {
  late CartRepositoryImpl repository;
  late MockCartLocalData mockLocalData;

  setUp(() {
    mockLocalData = MockCartLocalData();
    repository = CartRepositoryImpl(mockLocalData);
  });

  const tTableId = 'T001';
  const tCartModel = CartModel(tableId: tTableId, items: []);

  test('should return CartEntity when data is successfully retrieved from local storage', () async {
    // arrange
    when(() => mockLocalData.getCart(any())).thenAnswer((_) async => tCartModel);

    // act
    final result = await repository.getCart(tTableId);

    // assert
    expect(result, isA<Right<dynamic, CartEntity>>());
    verify(() => mockLocalData.getCart(tTableId)).called(1);
  });
}