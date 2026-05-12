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

  @override
  String get title_cart => 'Your Cart';

  @override
  String get add_button => 'Add';

  @override
  String get empty_message => 'Your cart is empty';

  @override
  String get back_to_menu => 'Back to Menu';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Tax (11%)';

  @override
  String get total => 'Grand Total';

  @override
  String get checkout => 'Proceed to Checkout';

  @override
  String get view_cart => 'View Cart';

  @override
  String items_count(int count) {
    return '$count Items';
  }

  @override
  String get notes_label => 'Notes';

  @override
  String get notes_hint => 'Example: No onions, spicy please...';

  @override
  String get required_label => 'Required';

  @override
  String get free_label => 'Free';

  @override
  String get add_to_cart => 'Add to Cart';

  @override
  String get spice_level => 'Spice Level';

  @override
  String get add_ons => 'Add-ons';

  @override
  String get save_changes => 'Save Changes';

  @override
  String get edit_item => 'Edit Item';

  @override
  String get title_order => 'Order Summary';

  @override
  String get checkout_button => 'Place Order';

  @override
  String get status_pending => 'Waiting for Confirmation';

  @override
  String get total_payment => 'Total Payment';

  @override
  String get success_message => 'Your order has been placed successfully';

  @override
  String get view_order_button => 'View My Order';

  @override
  String get ongoing_title => 'Order in Progress';

  @override
  String get status_processing => 'The chef is preparing your meal...';

  @override
  String get exit_alert_title => 'Exit Order Page?';

  @override
  String get exit_alert_message =>
      'Your order is still being processed. Are you sure you want to go back to the main menu?';

  @override
  String get exit_confirm => 'Yes, Exit';

  @override
  String get exit_cancel => 'Stay Here';
}
