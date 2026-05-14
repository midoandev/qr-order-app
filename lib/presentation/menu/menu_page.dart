import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/menu/widgets/cart_badge_fab.dart';

import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../../domain/entities/menu_entity.dart';
import '../cart/cart_page.dart';
import '../cart/cubits/cart_cubit.dart';
import 'cubits/menu_cubit.dart';
import 'cubits/menu_state.dart';
import 'widgets/add_to_cart_bottom_sheet.dart';
import 'widgets/build_category_group.dart';
import 'widgets/build_error_state.dart';

class MenuPage extends StatefulWidget {
  final String tableId;

  const MenuPage({super.key, required this.tableId});

  static const String route = '/menu';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<MenuCubit>().fetchMenu(widget.tableId);
    context.read<CartCubit>().fetchCart(widget.tableId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is MenuLoaded) {
              final table =
                  '${context.s.table_label} ${widget.tableId.substring(1, widget.tableId.length)}';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.data.restaurant.name,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(table, style: context.textTheme.labelSmall),
                ],
              );
            }
            return const Text("");
          },
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      floatingActionButton: CartBadgeFab(
        tableId: widget.tableId,
        onPressed: () async {
          await context.push(CartPage.route, extra: widget.tableId);
          if (context.mounted) {
            await context.read<CartCubit>().fetchCart(widget.tableId);
          }
        },
      ),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuError) {
            return BuildErrorState(message: state.message);
          }
          if (state is MenuEmpty) {
            return Center(child: Text(context.s.empty_menu));
          }
          if (state is MenuLoaded) {
            return _buildMenuContent(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMenuContent(BuildContext context, MenuLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 32),
      itemCount: state.data.categories.length,
      itemBuilder: (context, index) {
        final category = state.data.categories[index];
        final categoryItems = state.data.items
            .where((item) => item.categoryId == category.id)
            .toList();

        if (categoryItems.isEmpty) return const SizedBox.shrink();

        return BuildCategoryGroup(
          category: category,
          items: categoryItems,
          onItemTap: (MenuEntity item) {
            AddToCartBottomSheet.show(
              context,
              menu: item,
              tableId: widget.tableId,
            );
          },
        );
      },
    );
  }
}
