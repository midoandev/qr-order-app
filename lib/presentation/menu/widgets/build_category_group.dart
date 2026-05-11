import 'package:flutter/material.dart';

import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/menu_entity.dart';
import 'build_menu_item.dart';

class BuildCategoryGroup extends StatelessWidget {
  final CategoryEntity category;
  final List<MenuEntity> items;
  final Function(MenuEntity item) onItemTap;

  const BuildCategoryGroup({
    super.key,
    required this.category,
    required this.onItemTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          // childrenPadding: EdgeInsets.zero,
          initiallyExpanded: true,
          shape: const Border(),
          title: Text(
            category.name,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: context.colorScheme.surfaceContainerHighest
              .withValues(alpha: 0.3),
          children: items
              .map(
                (item) =>
                    BuildMenuItem(item: item, onTap: () => onItemTap(item)),
              )
              .toList(),
        ),
      ),
    );
  }
}
