import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/menu_entity.dart';

class BuildMenuItem extends StatelessWidget {
  final MenuEntity item;

  const BuildMenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              item.description,
              style: TextStyle(color: context.colorScheme.onSurfaceVariant),
            ),
          ),
          trailing: Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
          onTap: () {
            // Trigger Add to Cart atau Modal Detail Kustomisasi
          },
        ),
        Divider(
          height: 1,
          color: context.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ],
    );
  }
}
