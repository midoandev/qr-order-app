import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/ongoing_order/widgets/cooking_loader_animation.dart';

import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../../domain/entities/order_entity.dart';
import '../home/cubits/home_cubit.dart';
import '../home/home_page.dart';

class OngoingOrderPage extends StatefulWidget {
  static const String route = '/ongoing-order';
  final OrderEntity order;

  const OngoingOrderPage({super.key, required this.order});

  @override
  State<OngoingOrderPage> createState() => _OngoingOrderPageState();
}

class _OngoingOrderPageState extends State<OngoingOrderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Future<bool> _showExitConfirmation(BuildContext context) async {
  //   final result = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(context.s.exit_alert_title),
  //       content: Text(context.s.exit_alert_message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: Text(context.s.exit_cancel),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, true),
  //           child: Text(
  //             context.s.exit_confirm,
  //             style: TextStyle(color: context.colorScheme.error),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  //   return result ?? false;
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (context.mounted) {
          await context.read<HomeCubit>().loadOngoingOrders();
          context.mounted ? context.go(HomePage.route) : null;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.s.ongoing_title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              // final shouldPop = await _showExitConfirmation(context);
              if (context.mounted) {
                context.go(HomePage.route);
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusHeader(context),
              const SizedBox(height: 32),
              Text(
                context.s.title_order,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildOrderList(context),
              const Divider(height: 40),
              _buildPaymentDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CookingLoaderAnimation(controller: _controller),
          const SizedBox(height: 16),
          Text(
            context.s.status_processing,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Order ID: ${widget.order.id}",
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.order.items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = widget.order.items[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.quantity}x",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.menuItem.name,
                        style: context.textTheme.bodyLarge,
                      ),
                      if (item.selectedCustomizations.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            item.selectedCustomizations
                                .map((e) => "+ ${e.name}")
                                .join("\n"),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.outline,
                            ),
                          ),
                        ),
                      if (item.notes != null && item.notes!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "“${item.notes}”",
                            style: context.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text("\$${item.totalPrice.toStringAsFixed(2)}"),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.s.total,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "\$${widget.order.totalPrice.toStringAsFixed(2)}",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
