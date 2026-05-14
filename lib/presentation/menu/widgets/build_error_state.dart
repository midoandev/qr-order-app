import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../scanner/scanner_page.dart';

class BuildErrorState extends StatelessWidget {
  final String message;
  const BuildErrorState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () => context.pushReplacement(ScannerPage.route),
              child: Text(context.s.scan_button),
            ),
          ],
        ),
      ),
    );
  }
}
