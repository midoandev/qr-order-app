import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/extensions/localizations_extension.dart';
import '../../../core/extensions/theme_extention.dart';

class ScannerErrorWidget extends StatelessWidget {
  final MobileScannerException error;

  const ScannerErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = context.s.error_controller;
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = context.s.error_permission;
        break;
      case MobileScannerErrorCode.unsupported:
        errorMessage = context.s.error_unsupported;
        break;
      default:
        errorMessage = context.s.error_generic;
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Icon(
                Icons.camera_alt,
                color: context.colorScheme.error,
                size: 64,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.s.back),
            ),
          ],
        ),
      ),
    );
  }
}
