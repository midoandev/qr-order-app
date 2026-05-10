// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get back => '后退';

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

  @override
  String get error_controller => '扫描控制器未 saing.';

  @override
  String get error_permission => '相机权限 dipindah.';

  @override
  String get error_generic => '发生未知错误。';

  @override
  String get error_unsupported => '平台不支持。';

  @override
  String get error_no_camera => '未检测到相机。';

  @override
  String get table_label => 'Meja';

  @override
  String get empty_menu => 'Menu tidak tersedia saat ini.';

  @override
  String get menu_error => '加载菜单失败';

  @override
  String get menu_retry => '重试';
}
