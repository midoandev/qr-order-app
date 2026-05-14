import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';
import '../../scanner/scanner_page.dart';

class BuildCenterAction extends StatelessWidget {
  const BuildCenterAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(
                Icons.qr_code_scanner_rounded,
                size: 72,
                color: context.colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
             context.s.ready_order,
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            context.s.welcome_message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Primary Action Button with Elevation & Shape
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton.icon(
              onPressed: () => context.push(ScannerPage.route),
              icon: const Icon(Icons.camera_alt_rounded),
              label: Text(
                context.s.scan_button,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                shadowColor: context.colorScheme.primary.withValues(alpha: 0.4),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Subtle Hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: context.colorScheme.outline,
              ),
              const SizedBox(width: 8),
              Text(
                context.s.scan_info,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}