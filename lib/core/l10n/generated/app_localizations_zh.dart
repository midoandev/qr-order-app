// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get app_title => 'IPOT 订单';

  @override
  String get change_language => '更改语言';

  @override
  String get change_theme => '外观';

  @override
  String get light_mode => '浅色模式';

  @override
  String get dark_mode => '深色模式';

  @override
  String get english => 'English';

  @override
  String get chinese => '中文';

  @override
  String get welcome_message => '欢迎来到 Sushi Zen';

  @override
  String get scan_button => '扫描桌位二维码';
}
