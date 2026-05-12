import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'IPOT QR Order'**
  String get app_title;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @change_theme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get change_theme;

  /// No description provided for @light_mode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sushi Zen'**
  String get welcome_message;

  /// No description provided for @scan_button.
  ///
  /// In en, this message translates to:
  /// **'Scan Table QR'**
  String get scan_button;

  /// No description provided for @error_controller.
  ///
  /// In en, this message translates to:
  /// **'Scanner controller not ready.'**
  String get error_controller;

  /// No description provided for @error_permission.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied.'**
  String get error_permission;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get error_generic;

  /// No description provided for @error_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Platform not supported.'**
  String get error_unsupported;

  /// No description provided for @error_no_camera.
  ///
  /// In en, this message translates to:
  /// **'No camera detected.'**
  String get error_no_camera;

  /// No description provided for @table_label.
  ///
  /// In en, this message translates to:
  /// **'Table'**
  String get table_label;

  /// No description provided for @empty_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu is currently unavailable.'**
  String get empty_menu;

  /// No description provided for @menu_error.
  ///
  /// In en, this message translates to:
  /// **'Failed to load menu'**
  String get menu_error;

  /// No description provided for @menu_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get menu_retry;

  /// No description provided for @title_cart.
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get title_cart;

  /// No description provided for @add_button.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add_button;

  /// No description provided for @empty_message.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get empty_message;

  /// No description provided for @back_to_menu.
  ///
  /// In en, this message translates to:
  /// **'Back to Menu'**
  String get back_to_menu;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax (11%)'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get checkout;

  /// No description provided for @view_cart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get view_cart;

  /// No description provided for @items_count.
  ///
  /// In en, this message translates to:
  /// **'{count} Items'**
  String items_count(int count);

  /// No description provided for @notes_label.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes_label;

  /// No description provided for @notes_hint.
  ///
  /// In en, this message translates to:
  /// **'Example: No onions, spicy please...'**
  String get notes_hint;

  /// No description provided for @required_label.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required_label;

  /// No description provided for @free_label.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free_label;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart;

  /// No description provided for @spice_level.
  ///
  /// In en, this message translates to:
  /// **'Spice Level'**
  String get spice_level;

  /// No description provided for @add_ons.
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get add_ons;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;

  /// No description provided for @edit_item.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get edit_item;

  /// No description provided for @title_order.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get title_order;

  /// No description provided for @checkout_button.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get checkout_button;

  /// No description provided for @status_pending.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Confirmation'**
  String get status_pending;

  /// No description provided for @total_payment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get total_payment;

  /// No description provided for @success_message.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully'**
  String get success_message;

  /// No description provided for @view_order_button.
  ///
  /// In en, this message translates to:
  /// **'View My Order'**
  String get view_order_button;

  /// No description provided for @ongoing_title.
  ///
  /// In en, this message translates to:
  /// **'Order in Progress'**
  String get ongoing_title;

  /// No description provided for @status_processing.
  ///
  /// In en, this message translates to:
  /// **'The chef is preparing your meal...'**
  String get status_processing;

  /// No description provided for @exit_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Exit Order Page?'**
  String get exit_alert_title;

  /// No description provided for @exit_alert_message.
  ///
  /// In en, this message translates to:
  /// **'Your order is still being processed. Are you sure you want to go back to the main menu?'**
  String get exit_alert_message;

  /// No description provided for @exit_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, Exit'**
  String get exit_confirm;

  /// No description provided for @exit_cancel.
  ///
  /// In en, this message translates to:
  /// **'Stay Here'**
  String get exit_cancel;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
