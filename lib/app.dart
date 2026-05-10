import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrorder/core/navigation/app_router.dart';
import 'package:qrorder/core/theme/app_theme.dart';
import 'package:qrorder/presentation/settings/settings_cubit.dart';
import 'core/di/injection.dart';
import 'core/env/env_config.dart';
import 'core/l10n/generated/app_localizations.dart';
import 'presentation/settings/settings_state.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsCubit>(),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: env.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
          locale: state.locale,
          themeMode: state.themeMode,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}