import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';

class BuildEmptyState extends StatelessWidget {
  const BuildEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.remove_shopping_cart_outlined,
            size: 80,
            color: context.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            context.s.empty_message,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => context.pop(),
            child: Text(context.s.back_to_menu),
          ),
        ],
      ),
    );
  }
}
