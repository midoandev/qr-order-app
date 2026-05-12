import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/order/widgets/order_success.dart';
import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../../domain/entities/cart_entity.dart';
import 'cubits/order_cubit.dart';
import 'cubits/order_state.dart';

class OrderPage extends StatelessWidget {
  static const String route = '/order-page';
  final CartEntity cart;

  const OrderPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.s.title_order)),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, orderState) {
          if (orderState is OrderError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(orderState.message)));
          }
          if (orderState is OrderLoaded) {
            context.pushReplacement(
              OrderSuccess.route,
              extra: orderState.order,
            );
          }
        },
        builder: (context, orderState) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.menuItem.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.selectedCustomizations.isNotEmpty)
                            Text(
                              item.selectedCustomizations
                                  .map((e) => e.name)
                                  .join(', '),
                              style: context.textTheme.bodySmall,
                            ),
                          if (item.notes != null)
                            Text(
                              "${context.s.notes_label}: ${item.notes}",
                              style: context.textTheme.bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("x${item.quantity}"),
                          Text(
                            "\$${item.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              _buildBottomAction(context, cart.grandTotal, () {
                context.read<OrderCubit>().submitOrder(
                  tableId: cart.tableId,
                  cartItems: cart.items,
                );
              }, orderState is OrderLoading),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    double total,
    VoidCallback onCheckout,
    bool isLoading,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.s.total_payment,
                style: context.textTheme.titleMedium,
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isLoading ? null : onCheckout,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(context.s.checkout_button),
            ),
          ),
        ],
      ),
    );
  }
}
