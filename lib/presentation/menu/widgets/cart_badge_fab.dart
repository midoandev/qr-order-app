import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../cart/cubits/cart_cubit.dart';
import '../../cart/cubits/cart_state.dart';

class CartBadgeFab extends StatelessWidget {
  final String tableId;
  final VoidCallback onPressed;

  const CartBadgeFab({super.key, required this.tableId, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int totalItems = 0;
        if (state is CartLoaded) {
          totalItems = state.cart.items.length;
        }

        // if (totalItems == 0) return const SizedBox.shrink();

        return FloatingActionButton.extended(
          onPressed: onPressed,
          backgroundColor: context.colorScheme.primary,
          icon: Badge(
            label: Text('$totalItems'),
            backgroundColor: context.colorScheme.error,
            child: Icon(Icons.shopping_basket_rounded, color: context.colorScheme.onPrimary),
          ),
          label: Text(
            context.s.view_cart,
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}