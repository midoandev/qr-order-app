import 'package:flutter/material.dart';


extension MediaQueryExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  double get screenWidth => mq.size.width;
  double get screenHeight => mq.size.height;

  double get paddingTop => mq.padding.top;
  double get paddingBottom => mq.padding.bottom;

  bool get isLandscape => mq.orientation == Orientation.landscape;
}
