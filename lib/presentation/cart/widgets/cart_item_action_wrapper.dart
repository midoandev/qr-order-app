import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../cubits/cart_cubit.dart';
import 'cart_tile.dart';
import 'edit_item_bottom_sheet.dart';

class CartItemActionWrapper extends StatelessWidget {
  final CartItemEntity item;
  final String tableId;

  const CartItemActionWrapper({
    super.key,
    required this.item,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Simpan instance cubit sebelum masuk ke builder rute baru
        final cartCubit = context.read<CartCubit>();

        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (modalContext) {
            // Gunakan BlocProvider.value untuk mempassing cubit yang sudah ada
            return Container(
              color: context.colorScheme.surface,
              child: BlocProvider.value(
                value: cartCubit,
                child: EditItemBottomSheet(
                  item: item,
                  tableId: tableId,
                  onPress: (note, options) async {
                    await cartCubit.updateItemDetails(
                      tableId: tableId,
                      cartItemId: item.id,
                      selections: options,
                      notes: note,
                    );
                    if (modalContext.mounted) {
                      modalContext.pop();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
      child: CartTile(
        item: item,
        onRemove: () => context.read<CartCubit>().updateQuantity(
          tableId,
          item.id,
          item.quantity - 1,
        ),
        onAdd: () => context.read<CartCubit>().updateQuantity(
          tableId,
          item.id,
          item.quantity + 1,
        ),
      ),
    );
  }
}