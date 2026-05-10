import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import 'cubits/menu_cubit.dart';
import 'cubits/menu_state.dart';
import 'widgets/build_category_group.dart';
import 'widgets/build_error_state.dart';

class MenuPage extends StatefulWidget {
  final String tableId;

  const MenuPage({super.key, required this.tableId});

  static const String route = '/menu/:tableId';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    context.read<MenuCubit>().fetchMenu(widget.tableId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          pinned: false,
          title: Text(
            state.data.restaurant.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${context.s.table_label}: ${state.data.restaurant.tableId}',
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final category = state.data.categories[index];
            final categoryItems = state.data.items
                .where((item) => item.categoryId == category.id)
                .toList();

            if (categoryItems.isEmpty) return const SizedBox.shrink();

            return BuildCategoryGroup(category: category, items: categoryItems);
          }, childCount: state.data.categories.length),
        ),
      ],
    );
  }
}
