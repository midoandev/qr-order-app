// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get back => 'Back';

  @override
  String get app_title => 'IPOT QR Order';

  @override
  String get change_language => 'Change Language';

  @override
  String get change_theme => 'Appearance';

  @override
  String get light_mode => 'Light Mode';

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get welcome_message => 'Welcome to Sushi Zen';

  @override
  String get scan_button => 'Scan Table QR';

  @override
  String get error_controller => 'Scanner controller not ready.';

  @override
  String get error_permission => 'Camera permission denied.';

  @override
  String get error_generic => 'An unexpected error occurred.';

  @override
  String get error_unsupported => 'Platform not supported.';

  @override
  String get error_no_camera => 'No camera detected.';

  @override
  String get table_label => 'Table';

  @override
  String get empty_menu => 'Menu is currently unavailable.';

  @override
  String get menu_error => 'Failed to load menu';

  @override
  String get menu_retry => 'Retry';
}
