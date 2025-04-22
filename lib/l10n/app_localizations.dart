import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'JayJay Starter'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get test;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @themeSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get notificationsDisabled;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @checkUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check Updates'**
  String get checkUpdates;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @userAgreement.
  ///
  /// In en, this message translates to:
  /// **'User Agreement'**
  String get userAgreement;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @premiumBenefits.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features and remove ads'**
  String get premiumBenefits;

  /// No description provided for @premiumStatus.
  ///
  /// In en, this message translates to:
  /// **'Premium Status'**
  String get premiumStatus;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @expireDate.
  ///
  /// In en, this message translates to:
  /// **'Expire Date'**
  String get expireDate;

  /// No description provided for @noAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// No description provided for @unlimitedRequests.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Requests'**
  String get unlimitedRequests;

  /// No description provided for @unlimitedStorage.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Storage'**
  String get unlimitedStorage;

  /// No description provided for @unlimitedHistory.
  ///
  /// In en, this message translates to:
  /// **'Unlimited History'**
  String get unlimitedHistory;

  /// No description provided for @advancedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Advanced Features'**
  String get advancedFeatures;

  /// No description provided for @monthlyPlan.
  ///
  /// In en, this message translates to:
  /// **'Monthly Plan'**
  String get monthlyPlan;

  /// No description provided for @yearlyPlan.
  ///
  /// In en, this message translates to:
  /// **'Yearly Plan'**
  String get yearlyPlan;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get perMonth;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'per year'**
  String get perYear;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @purchaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Purchase Success'**
  String get purchaseSuccess;

  /// No description provided for @purchaseSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support! You are now a premium member.'**
  String get purchaseSuccessMessage;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase Failed'**
  String get purchaseFailed;

  /// No description provided for @purchaseFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to complete the purchase. Please try again later.'**
  String get purchaseFailedMessage;

  /// No description provided for @businessTest.
  ///
  /// In en, this message translates to:
  /// **'Business Test'**
  String get businessTest;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessDescription.
  ///
  /// In en, this message translates to:
  /// **'Business Description'**
  String get businessDescription;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @createBusiness.
  ///
  /// In en, this message translates to:
  /// **'Create Business'**
  String get createBusiness;

  /// No description provided for @remainingOperations.
  ///
  /// In en, this message translates to:
  /// **'Remaining Operations: {count}'**
  String remainingOperations(int count);

  /// No description provided for @remainingBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Remaining Businesses: {count}'**
  String remainingBusinesses(int count);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadingComplete.
  ///
  /// In en, this message translates to:
  /// **'Loading Complete'**
  String get loadingComplete;

  /// No description provided for @loadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Loading Failed: {error}'**
  String loadingFailed(String error);

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Data'**
  String get clearData;

  /// No description provided for @dataCleared.
  ///
  /// In en, this message translates to:
  /// **'Data Cleared'**
  String get dataCleared;

  /// No description provided for @clearFailed.
  ///
  /// In en, this message translates to:
  /// **'Clear Failed: {error}'**
  String clearFailed(String error);

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'This is a sample application that demonstrates how to build a fully functional Flutter application.'**
  String get appDescription;

  /// No description provided for @usageLimits.
  ///
  /// In en, this message translates to:
  /// **'Usage Limits'**
  String get usageLimits;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Premium Features'**
  String get premiumFeatures;

  /// No description provided for @featureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get featureNoAds;

  /// No description provided for @featureUnlimitedRequests.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Requests'**
  String get featureUnlimitedRequests;

  /// No description provided for @featureUnlimitedStorage.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Storage'**
  String get featureUnlimitedStorage;

  /// No description provided for @featureUnlimitedHistory.
  ///
  /// In en, this message translates to:
  /// **'Unlimited History'**
  String get featureUnlimitedHistory;

  /// No description provided for @featureAdvancedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Advanced Features'**
  String get featureAdvancedFeatures;

  /// No description provided for @dailyRequests.
  ///
  /// In en, this message translates to:
  /// **'Daily Requests'**
  String get dailyRequests;

  /// No description provided for @storageLimit.
  ///
  /// In en, this message translates to:
  /// **'Storage Limit'**
  String get storageLimit;

  /// No description provided for @historyLimit.
  ///
  /// In en, this message translates to:
  /// **'History Limit'**
  String get historyLimit;

  /// No description provided for @usageStats.
  ///
  /// In en, this message translates to:
  /// **'Usage Statistics'**
  String get usageStats;

  /// No description provided for @todayRequests.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Requests'**
  String get todayRequests;

  /// No description provided for @storageUsage.
  ///
  /// In en, this message translates to:
  /// **'Storage Usage'**
  String get storageUsage;

  /// No description provided for @historyRecords.
  ///
  /// In en, this message translates to:
  /// **'History Records'**
  String get historyRecords;

  /// No description provided for @upgradeToPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremiumTitle;

  /// No description provided for @upgradeToPremiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlock all limits and enjoy unlimited usage'**
  String get upgradeToPremiumDesc;

  /// No description provided for @notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not Logged In'**
  String get notLoggedIn;

  /// No description provided for @premiumPurchase.
  ///
  /// In en, this message translates to:
  /// **'Premium Purchase'**
  String get premiumPurchase;

  /// No description provided for @purchaseServiceError.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to purchase service'**
  String get purchaseServiceError;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore Success'**
  String get restoreSuccess;

  /// No description provided for @restoreSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your purchases have been restored.'**
  String get restoreSuccessMessage;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore Failed'**
  String get restoreFailed;

  /// No description provided for @restoreFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore purchases'**
  String get restoreFailedMessage;

  /// No description provided for @choosePlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Plan'**
  String get choosePlan;

  /// No description provided for @purchaseNow.
  ///
  /// In en, this message translates to:
  /// **'Purchase Now'**
  String get purchaseNow;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// No description provided for @featureEarlyAccess.
  ///
  /// In en, this message translates to:
  /// **'Early access to new features'**
  String get featureEarlyAccess;

  /// No description provided for @featurePrioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority customer support'**
  String get featurePrioritySupport;

  /// No description provided for @premiumUpgradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get premiumUpgradeTitle;

  /// No description provided for @premiumUpgradeDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features and remove ads'**
  String get premiumUpgradeDescription;

  /// No description provided for @premiumFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'Enjoy ad-free experience'**
  String get premiumFeatureNoAds;

  /// No description provided for @premiumFeatureUnlimitedRequests.
  ///
  /// In en, this message translates to:
  /// **'Make unlimited requests'**
  String get premiumFeatureUnlimitedRequests;

  /// No description provided for @premiumFeatureUnlimitedStorage.
  ///
  /// In en, this message translates to:
  /// **'Get unlimited storage space'**
  String get premiumFeatureUnlimitedStorage;

  /// No description provided for @premiumFeatureAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Access advanced features'**
  String get premiumFeatureAdvanced;

  /// No description provided for @premiumUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get premiumUpgradeButton;

  /// No description provided for @premiumLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Limit Reached'**
  String get premiumLimitReachedTitle;

  /// No description provided for @premiumLimitReachedDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the limit of your free plan. Upgrade to premium to continue.'**
  String get premiumLimitReachedDescription;

  /// No description provided for @premiumTrialExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Trial Expired'**
  String get premiumTrialExpiredTitle;

  /// No description provided for @premiumTrialExpiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Your trial period has expired. Upgrade to premium to continue using all features.'**
  String get premiumTrialExpiredDescription;

  /// No description provided for @errorOperationLimitReached.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the operation limit for free users. Please upgrade to premium.'**
  String get errorOperationLimitReached;

  /// No description provided for @errorBusinessLimitReached.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the business limit for free users. Please upgrade to premium.'**
  String get errorBusinessLimitReached;

  /// No description provided for @errorPremiumRequired.
  ///
  /// In en, this message translates to:
  /// **'This feature requires premium membership. Please upgrade to continue.'**
  String get errorPremiumRequired;

  /// No description provided for @errorOperationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String errorOperationFailed(String error);

  /// No description provided for @businessList.
  ///
  /// In en, this message translates to:
  /// **'Business List'**
  String get businessList;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Update successful'**
  String get updateSuccess;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed: {error}'**
  String updateFailed(String error);

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delete successful'**
  String get deleteSuccess;

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String deleteFailed(String error);

  /// No description provided for @premiumLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Free user limit reached'**
  String get premiumLimitReached;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
