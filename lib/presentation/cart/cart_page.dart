import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/cart/widgets/cart_item_action_wrapper.dart';
import 'package:qrorder/presentation/order/order_page.dart';

import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../widgets/build_checkout_bottom_bar.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/cart_state.dart';
import 'widgets/build_empty_state.dart';

class CartPage extends StatefulWidget {
  final String tableId;
  static const String route = '/cart';

  const CartPage({super.key, required this.tableId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchCart(widget.tableId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.s.title_cart,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartEmpty) return const BuildEmptyState();
          if (state is CartError) return Center(child: Text(state.message));
          if (state is CartLoaded) return _buildCartContent(context, state);
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.cart.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = state.cart.items[index];
              return CartItemActionWrapper(item: item, tableId: widget.tableId);
            },
          ),
        ),
        BuildCheckoutBottomBar(
          cart: state.cart,
          isCartPage: true,
          onPressCheckout: () {
            context.push(OrderPage.route, extra: state.cart);
          },
        ),
      ],
    );
  }
}
