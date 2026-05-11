import 'package:flutter_test/flutter_test.dart';
import 'package:qrorder/data/datasources/cart_local_data.dart';
import 'package:qrorder/data/models/cart_item_model.dart';
import 'package:qrorder/data/models/customization_option_model.dart';
import 'package:qrorder/data/models/menu_model.dart';

void main() {
  late CartLocalDataImpl dataSource;

  setUp(() {
    dataSource = CartLocalDataImpl();
  });

  final tMenuModel = MenuModel(
    id: 1,
    name: 'Salmon Sashimi',
    description: 'Fresh salmon',
    price: 10.0,
    categoryId: 1,
    customizationGroups: const [],
  );

  final tOptionA = CustomizationOptionModel(id: 101, name: 'Spicy', priceModifier: 2.0);
  final tOptionB = CustomizationOptionModel(id: 102, name: 'Wasabi Extra', priceModifier: 1.0);

  test('should add a new row if the item is the same but the customizations are different', () async {
    const tTableId = 'T001';

    // 1. Tambah Item A dengan Opsi A
    final item1 = CartItemModel(
      id: 'temp1',
      menuItem: tMenuModel,
      quantity: 1,
      selectedCustomizations: [tOptionA],
    );
    await dataSource.addToCart(tTableId, item1);

    // 2. Tambah Item A dengan Opsi B
    final item2 = CartItemModel(
      id: 'temp2',
      menuItem: tMenuModel,
      quantity: 1,
      selectedCustomizations: [tOptionB],
    );
    final result = await dataSource.addToCart(tTableId, item2);

    // Assert: Harus ada 2 item di keranjang
    expect(result.items.length, 2);
    expect(result.items[0].selectedCustomizations[0].id, 101);
    expect(result.items[1].selectedCustomizations[0].id, 102);
  });

  test('should increase the quantity if the item and customizations are exactly the same', () async {
    const tTableId = 'T001';

    final item = CartItemModel(
      id: 'temp',
      menuItem: tMenuModel,
      quantity: 1,
      selectedCustomizations: [tOptionA],
    );

    await dataSource.addToCart(tTableId, item);
    final result = await dataSource.addToCart(tTableId, item);

    // Assert: Tetap 1 baris, tapi quantity jadi 2
    expect(result.items.length, 1);
    expect(result.items[0].quantity, 2);
  });
}