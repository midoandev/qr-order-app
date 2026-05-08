import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qrorder/domain/entities/order_entity.dart';
import 'package:qrorder/domain/entities/order_item_entity.dart';
import 'package:qrorder/domain/entities/order_request_entity.dart';
import 'package:qrorder/domain/repositories/order_repository.dart';
import 'package:qrorder/domain/usecases/submit_order_use_case.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

// Fake class untuk registerFallbackValue
class OrderRequestEntityFake extends Fake implements OrderRequestEntity {}

void main() {
  late SubmitOrderUseCase useCase;
  late MockOrderRepository mockRepository;

  setUpAll(() {
    // Registrasi fallback agar 'any()' bisa mengenali tipe OrderRequestEntity
    registerFallbackValue(OrderRequestEntityFake());
  });

  setUp(() {
    mockRepository = MockOrderRepository();
    useCase = SubmitOrderUseCase(mockRepository);
  });

  final tOrderRequest = OrderRequestEntity(
    tableId: 'T001',
    customerNote: 'No MSG',
    items: [
      OrderItemEntity(menuItemId: 1, quantity: 2),
    ],
  );

  final tOrderResponse = OrderEntity(
    id: 101,
    tableId: 'T001',
    status: 'pending',
    totalPrice: 25.0,
  );

  test('should submit order to the repository and return OrderEntity', () async {
    // arrange
    when(() => mockRepository.submitOrder(any()))
        .thenAnswer((_) async => Right(tOrderResponse));

    // act
    final result = await useCase.execute(
      tableId: tOrderRequest.tableId,
      items: tOrderRequest.items,
      customerNote: tOrderRequest.customerNote,
    );

    // assert
    expect(result, Right(tOrderResponse));
    verify(() => mockRepository.submitOrder(any())).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}