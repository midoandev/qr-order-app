import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../scanner/scanner_page.dart';
import '../settings/settings_cubit.dart';
import '../settings/settings_state.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<SettingsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.s.app_title),
        actions: [
          IconButton(
            icon: Icon(
              settingsState.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => _showSettingsBottomSheet(context),
          ),
        ],
      ),
      body: Center(
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
              onPressed: () {
                context.push(ScannerPage.route);
                //if ios simulator use this
                // context.pushReplacement(MenuPage.route, extra: 'T001');
              },
              icon: const Icon(Icons.camera_alt),
              label: Text(context.s.scan_button),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bContext) {
        // Menggunakan BlocProvider.value untuk meneruskan Cubit ke dalam bottom sheet
        return BlocProvider.value(
          value: context.read<SettingsCubit>(),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.s.change_theme,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text(context.s.light_mode),
                          icon: const Icon(Icons.light_mode),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text(context.s.dark_mode),
                          icon: const Icon(Icons.dark_mode),
                        ),
                      ],
                      selected: {state.themeMode},
                      onSelectionChanged: (Set<ThemeMode> newSelection) {
                        context.read<SettingsCubit>().toggleTheme(
                          newSelection.first,
                        );
                      },
                    ),
                    const Divider(height: 48),
                    Text(
                      context.s.change_language,
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(context.s.english),
                      leading: const Text(
                        "🇺🇸",
                        style: TextStyle(fontSize: 24),
                      ),
                      trailing: context.isEn
                          ? Icon(
                              Icons.check_circle,
                              color: context.colorScheme.primary,
                            )
                          : null,
                      onTap: () {
                        context.read<SettingsCubit>().changeLanguage('en');
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(context.s.chinese),
                      leading: const Text(
                        "🇨🇳",
                        style: TextStyle(fontSize: 24),
                      ),
                      trailing: context.isEn
                          ? null
                          : Icon(
                              Icons.check_circle,
                              color: context.colorScheme.primary,
                            ),
                      onTap: () {
                        context.read<SettingsCubit>().changeLanguage('zh');
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
