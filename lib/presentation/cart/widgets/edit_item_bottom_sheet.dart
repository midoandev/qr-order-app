import 'package:flutter/material.dart';
import '../../../core/extensions/localizations_extension.dart';
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
        children: [
          CustomizationSelectorWidget(
            groups: widget.item.menuItem.customizationGroups,
            initialSelections: _currentSelections,
            onSelectionChanged: (selections) {
              _currentSelections = selections.values.expand((e) => e).toList();
            },
          ),
          TextField(controller: _notesController),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () =>
                widget.onPress(_notesController.text, _currentSelections),
            child: Text(context.s.save_changes),
          ),
        ],
      ),
    );
  }
}
