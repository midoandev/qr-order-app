import 'package:flutter/material.dart';

extension ThemeExtention on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;
}

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;

  double get paddingTop => mq.padding.top;
  double get paddingBottom => mq.padding.bottom;

  bool get isLandscape => mq.orientation == Orientation.landscape;
}
