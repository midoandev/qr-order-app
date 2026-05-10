import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import 'widgets/scanner_error_widget.dart';
import 'cubits/scanner_cubit.dart';
import 'cubits/scanner_state.dart';

class ScannerPage extends StatefulWidget {
  static const String route = '/scanner';

  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late final MobileScannerController controller;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerCubit, ScannerState>(
      listener: (context, state) async {
        if (state is ScannerDetected && !_isNavigating) {
          _isNavigating = true;
          await controller.stop();
          if (context.mounted) {
            context.pushReplacement('/menu/${state.tableId}');
            await controller.pause();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.s.scan_button),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  errorBuilder: (_, error) {
                    return ScannerErrorWidget(error: error);
                  },
                  fit: BoxFit.cover,
                  onDetect: (capture) {
                    if (_isNavigating) return;
                    for (final barcode in capture.barcodes) {
                      if (barcode.rawValue != null) {
                        context.read<ScannerCubit>().onQrDetected(barcode.rawValue!);
                      }
                    }
                  },
                ),
                _buildOverlay(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.primary.withValues(alpha: 0.8),
            width: 4,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
