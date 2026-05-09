import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

extension ContextExt on BuildContext {
  S get s => S.of(this)!;
  Locale get currentLocale => Localizations.localeOf(this);


  bool get isEn => currentLocale.languageCode == 'en';

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
