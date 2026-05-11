import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrorder/core/extensions/media_query_extension.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/customization_option_entity.dart';
import '../../../domain/entities/menu_entity.dart';
import '../../cart/cubits/cart_cubit.dart';
import '../../widgets/customization_selector_widget.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final MenuEntity menu;
  final String tableId;

  const AddToCartBottomSheet({
    super.key,
    required this.menu,
    required this.tableId,
  });

  static Future<void> show(
    BuildContext context, {
    required MenuEntity menu,
    required String tableId,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CartCubit>(),
        child: AddToCartBottomSheet(menu: menu, tableId: tableId),
      ),
    );
  }

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int _quantity = 1;
  final TextEditingController _notesController = TextEditingController();
  List<CustomizationOptionEntity> _selectedOptions = [];

  double _calculateCurrentTotal() {
    final extra = _selectedOptions.fold(
      0.0,
      (sum, opt) => sum + opt.priceModifier,
    );
    return (widget.menu.price + extra) * _quantity;
  }

  void _handleCustomizationChanged(
    Map<int, List<CustomizationOptionEntity>> selections,
  ) {
    setState(() {
      _selectedOptions = selections.values
          .expand((element) => element)
          .toList();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.viewInsets.bottom + 24,
        top: 16,
      ),
      constraints: BoxConstraints(maxHeight: context.screenHeight * 0.85, minHeight: context.screenHeight * .5),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const Divider(height: 32),

                  // Menampilkan Customization Groups jika tersedia
                  if (widget.menu.customizationGroups.isNotEmpty) ...[
                    CustomizationSelectorWidget(
                      groups: widget.menu.customizationGroups,
                      onSelectionChanged: _handleCustomizationChanged,
                    ),
                    const Divider(height: 32),
                  ],

                  Text(
                    context.s.notes_label,
                    style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: context.s.notes_hint,
                      filled: true,
                      fillColor: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 100), // Spacer untuk bottom bar
                ],
              ),
            ),
          ),

          _buildBottomAction(context),
        ],
      ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.menu.name, style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(widget.menu.description, style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, context.paddingBottom),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          _buildQuantityCounter(context),
          const SizedBox(width: 16),
          Expanded(
            child: FilledButton(
              onPressed: _validateAndSubmit,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                "${context.s.add_button} • \$${_calculateCurrentTotal().toStringAsFixed(2)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildQuantityCounter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(onPressed: () => setState(() { if(_quantity > 1) _quantity--; }), icon: const Icon(Icons.remove)),
          Text('$_quantity', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          IconButton(onPressed: () => setState(() { _quantity++; }), icon: const Icon(Icons.add)),
        ],
      ),
    );
  }

  void _validateAndSubmit() {
    // Validasi requirement kustomisasi jika perlu di sini
    final cartItem = CartItemEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      menuItem: widget.menu,
      quantity: _quantity,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      selectedCustomizations: _selectedOptions,
    );

    context.read<CartCubit>().addItem(widget.tableId, cartItem);
    Navigator.pop(context);
  }
}
