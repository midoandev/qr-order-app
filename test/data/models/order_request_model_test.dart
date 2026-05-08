import 'package:flutter_test/flutter_test.dart';
import 'package:qrorder/data/models/order_request_model.dart';
import 'package:qrorder/domain/entities/customization_item_entity.dart';
import 'package:qrorder/domain/entities/order_item_entity.dart';
import 'package:qrorder/domain/entities/order_request_entity.dart';

void main() {
  final tEntity = OrderRequestEntity(
    tableId: 'T001',
    customerNote: 'Less sugar',
    items: [
      OrderItemEntity(
        menuItemId: 1,
        quantity: 1,
        customizations: [CustomizationItemEntity(optionId: 10, quantity: 1)],
      ),
    ],
  );

  group('OrderRequestModel Serialization', () {
    test('should return a valid JSON map from OrderRequestEntity', () {
      // arrange
      final model = OrderRequestModel.fromEntity(tEntity);

      // act
      final result = model.toJson();

      // assert
      final expectedJson = {
        'table_id': 'T001',
        'customer_note': 'Less sugar',
        'items': [
          {
            'menu_item_id': 1,
            'quantity': 1,
            'customizations': [
              {'option_id': 10, 'quantity': 1},
            ],
          },
        ],
      };
      expect(result, expectedJson);
    });
  });
}
