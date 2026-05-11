import 'package:flutter/material.dart';
import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../../domain/entities/customization_group_entity.dart';
import '../../domain/entities/customization_option_entity.dart';

class CustomizationSelectorWidget extends StatefulWidget {
  final List<CustomizationGroupEntity> groups;
  final List<CustomizationOptionEntity> initialSelections;
  final Function(Map<int, List<CustomizationOptionEntity>>) onSelectionChanged;

  const CustomizationSelectorWidget({
    super.key,
    required this.groups,
    this.initialSelections = const [],
    required this.onSelectionChanged,
  });

  @override
  State<CustomizationSelectorWidget> createState() => _CustomizationSelectorWidgetState();
}

class _CustomizationSelectorWidgetState extends State<CustomizationSelectorWidget> {
  final Map<int, List<CustomizationOptionEntity>> _selectedOptions = {};
  @override
  void initState() {
    super.initState();
    _mapInitialSelections();
  }

  void _mapInitialSelections() {
    for (var group in widget.groups) {
      final matches = widget.initialSelections.where((selected) =>
          group.options.any((opt) => opt.id == selected.id)).toList();
      if (matches.isNotEmpty) {
        _selectedOptions[group.id] = matches;
      }
    }
  }
  void _handleOptionTap(CustomizationGroupEntity group, CustomizationOptionEntity option) {
    setState(() {
      final currentSelections = _selectedOptions[group.id] ?? [];

      if (group.maxSelections == 1) {
        _selectedOptions[group.id] = [option];
      } else {
        if (currentSelections.contains(option)) {
          currentSelections.remove(option);
        } else if (currentSelections.length < group.maxSelections) {
          currentSelections.add(option);
        }
        _selectedOptions[group.id] = currentSelections;
      }
    });
    widget.onSelectionChanged(_selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.groups.map((group) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    group.name,
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  if (group.isRequired)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        context.s.required_label,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ...group.options.map((option) {
                final isSelected = _selectedOptions[group.id]?.contains(option) ?? false;
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (_) => _handleOptionTap(group, option),
                  title: Text(option.name),
                  secondary: Text(
                    option.priceModifier > 0
                        ? "+ \$${option.priceModifier.toStringAsFixed(2)}"
                        : context.s.free_label,
                    style: TextStyle(color: context.colorScheme.primary),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  checkboxShape: group.maxSelections == 1 ? const CircleBorder() : null,
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}