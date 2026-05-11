import 'package:flutter/material.dart';
import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/customization_option_entity.dart';
import '../../widgets/customization_selector_widget.dart';

class EditItemBottomSheet extends StatefulWidget {
  final CartItemEntity item;
  final String tableId;
  final Function(String note, List<CustomizationOptionEntity> option) onPress;

  const EditItemBottomSheet({
    super.key,
    required this.item,
    required this.tableId,
    required this.onPress,
  });

  @override
  State<EditItemBottomSheet> createState() => _EditItemBottomSheetState();
}

class _EditItemBottomSheetState extends State<EditItemBottomSheet> {
  late List<CustomizationOptionEntity> _currentSelections;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _currentSelections = List.from(widget.item.selectedCustomizations);
    _notesController = TextEditingController(text: widget.item.notes);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomizationSelectorWidget(
            groups: widget.item.menuItem.customizationGroups,
            initialSelections: _currentSelections,
            onSelectionChanged: (selections) {
              _currentSelections = selections.values.expand((e) => e).toList();
            },
          ),
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
          const SizedBox(height: 24),
          Row(mainAxisSize: MainAxisSize.max,children: [
            Expanded(child: FilledButton(
              onPressed: () => widget.onPress(
                _notesController.text,
                _currentSelections,
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                context.s.save_changes,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ))
          ],)
        ],
      ),
    );
  }
}
