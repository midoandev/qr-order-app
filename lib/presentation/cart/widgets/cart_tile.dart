import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/cart_item_entity.dart';
import 'quantity_control.dart';

class CartTile extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const CartTile({super.key, required this.item, required this.onRemove, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.menuItem.name, style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                if (item.selectedCustomizations.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.selectedCustomizations.map((e) => e.name).join(", "),
                      style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                    ),
                  ),
                if (item.notes != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text("Note: ${item.notes}", style: context.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
                  ),
                const SizedBox(height: 8),
                Text("\$${item.totalPrice.toStringAsFixed(2)}", style: TextStyle(color: context.colorScheme.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          QuantityControl(quantity: item.quantity, onRemove: onRemove, onAdd: onAdd),
        ],
      ),
    );
  }
}