// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'JayJay Starter';

  @override
  String get home => 'Home';

  @override
  String get test => 'Test';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get notificationsEnabled => 'Enabled';

  @override
  String get notificationsDisabled => 'Disabled';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get aboutApp => 'About App';

  @override
  String get version => 'Version';

  @override
  String get checkUpdates => 'Check Updates';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get userAgreement => 'User Agreement';

  @override
  String get premium => 'Premium';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get premiumBenefits => 'Unlock all features and remove ads';

  @override
  String get premiumStatus => 'Premium Status';

  @override
  String get upgradeNow => 'Upgrade Now';

  @override
  String get expireDate => 'Expire Date';

  @override
  String get noAds => 'No Ads';

  @override
  String get unlimitedRequests => 'Unlimited Requests';

  @override
  String get unlimitedStorage => 'Unlimited Storage';

  @override
  String get unlimitedHistory => 'Unlimited History';

  @override
  String get advancedFeatures => 'Advanced Features';

  @override
  String get monthlyPlan => 'Monthly Plan';

  @override
  String get yearlyPlan => 'Yearly Plan';

  @override
  String get perMonth => 'per month';

  @override
  String get perYear => 'per year';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get purchaseSuccess => 'Purchase Success';

  @override
  String get purchaseSuccessMessage => 'Thank you for your support! You are now a premium member.';

  @override
  String get purchaseFailed => 'Purchase Failed';

  @override
  String get purchaseFailedMessage => 'Failed to complete the purchase. Please try again later.';

  @override
  String get businessTest => 'Business Test';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessDescription => 'Business Description';

  @override
  String get userId => 'User ID';

  @override
  String get createBusiness => 'Create Business';

  @override
  String remainingOperations(int count) {
    return 'Remaining Operations: $count';
  }

  @override
  String remainingBusinesses(int count) {
    return 'Remaining Businesses: $count';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get loadingComplete => 'Loading Complete';

  @override
  String loadingFailed(String error) {
    return 'Loading Failed: $error';
  }

  @override
  String get clearData => 'Clear Data';

  @override
  String get dataCleared => 'Data Cleared';

  @override
  String clearFailed(String error) {
    return 'Clear Failed: $error';
  }

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get appDescription => 'This is a sample application that demonstrates how to build a fully functional Flutter application.';

  @override
  String get usageLimits => 'Usage Limits';

  @override
  String get premiumFeatures => 'Premium Features';

  @override
  String get featureNoAds => 'No Ads';

  @override
  String get featureUnlimitedRequests => 'Unlimited Requests';

  @override
  String get featureUnlimitedStorage => 'Unlimited Storage';

  @override
  String get featureUnlimitedHistory => 'Unlimited History';

  @override
  String get featureAdvancedFeatures => 'Advanced Features';

  @override
  String get dailyRequests => 'Daily Requests';

  @override
  String get storageLimit => 'Storage Limit';

  @override
  String get historyLimit => 'History Limit';

  @override
  String get usageStats => 'Usage Statistics';

  @override
  String get todayRequests => 'Today\'s Requests';

  @override
  String get storageUsage => 'Storage Usage';

  @override
  String get historyRecords => 'History Records';

  @override
  String get upgradeToPremiumTitle => 'Upgrade to Premium';

  @override
  String get upgradeToPremiumDesc => 'Unlock all limits and enjoy unlimited usage';

  @override
  String get notLoggedIn => 'Not Logged In';

  @override
  String get premiumPurchase => 'Premium Purchase';

  @override
  String get purchaseServiceError => 'Unable to connect to purchase service';

  @override
  String get restoreSuccess => 'Successfully restored from iCloud';

  @override
  String get restoreSuccessMessage => 'Your purchases have been restored.';

  @override
  String get restoreFailed => 'Failed to restore from iCloud';

  @override
  String get restoreFailedMessage => 'Failed to restore purchases';

  @override
  String get choosePlan => 'Choose Plan';

  @override
  String get purchaseNow => 'Purchase Now';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get featureEarlyAccess => 'Early access to new features';

  @override
  String get featurePrioritySupport => 'Priority customer support';

  @override
  String get premiumUpgradeTitle => 'Upgrade to Premium';

  @override
  String get premiumUpgradeDescription => 'Unlock all features and remove ads';

  @override
  String get premiumFeatureNoAds => 'Enjoy ad-free experience';

  @override
  String get premiumFeatureUnlimitedRequests => 'Make unlimited requests';

  @override
  String get premiumFeatureUnlimitedStorage => 'Get unlimited storage space';

  @override
  String get premiumFeatureAdvanced => 'Access advanced features';

  @override
  String get premiumUpgradeButton => 'Upgrade Now';

  @override
  String get premiumLimitReachedTitle => 'Limit Reached';

  @override
  String get premiumLimitReachedDescription => 'You\'ve reached the limit of your free plan. Upgrade to premium to continue.';

  @override
  String get premiumTrialExpiredTitle => 'Trial Expired';

  @override
  String get premiumTrialExpiredDescription => 'Your trial period has expired. Upgrade to premium to continue using all features.';

  @override
  String get errorOperationLimitReached => 'You\'ve reached the operation limit for free users. Please upgrade to premium.';

  @override
  String get errorBusinessLimitReached => 'You\'ve reached the business limit for free users. Please upgrade to premium.';

  @override
  String get errorPremiumRequired => 'This feature requires premium membership. Please upgrade to continue.';

  @override
  String errorOperationFailed(String error) {
    return 'Operation failed: $error';
  }

  @override
  String get businessList => 'Business List';

  @override
  String get updateSuccess => 'Update successful';

  @override
  String updateFailed(String error) {
    return 'Update failed: $error';
  }

  @override
  String get deleteSuccess => 'Delete successful';

  @override
  String deleteFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String get premiumLimitReached => 'Free user limit reached';

  @override
  String get iCloudSync => 'iCloud Sync';

  @override
  String get iCloudSyncDescription => 'Sync your data to iCloud or restore from iCloud';

  @override
  String get syncToICloud => 'Sync to iCloud';

  @override
  String get restoreFromICloud => 'Restore from iCloud';

  @override
  String get syncSuccess => 'Successfully synced to iCloud';

  @override
  String get syncFailed => 'Failed to sync to iCloud';
}
