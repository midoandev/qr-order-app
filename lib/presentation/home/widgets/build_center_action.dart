import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../scanner/scanner_page.dart';

class BuildCenterAction extends StatelessWidget {
  const BuildCenterAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_scanner,
            size: 80,
            color: context.colorScheme.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 24),
          Text(
            context.s.welcome_message,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => context.push(ScannerPage.route),
            icon: const Icon(Icons.camera_alt),
            label: Text(context.s.scan_button),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
