import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/domain/entities/order_entity.dart';
import 'package:qrorder/presentation/ongoing_order/ongoing_order_page.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';

class OrderSuccess extends StatelessWidget {
  static const String route = '/order-success';
  final OrderEntity order;

  const OrderSuccess({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer.withValues(
                    alpha: 0.5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: context.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                context.s.success_message,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.pushReplacement(
                    OngoingOrderPage.route,
                    extra: order,
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(context.s.view_order_button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
