import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void changeLanguage(String languageCode) {
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  void toggleTheme(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}