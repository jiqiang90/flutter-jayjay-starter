# JayJay Starter: A Flutter Application Development Starter

## Project Overview

This is a Flutter application development starter template that integrates the following core features:
- In-App Purchase
- Google AdMob Advertising
- Local Database Storage
- Service Layer Architecture
- UI Component Library
- Multi-language Support
- Theme Management

## Configuration Management

### 1. Environment Variables
The project uses environment variables for sensitive configurations:
```dart
// Example of environment variables
const String kAdMobAppId = String.fromEnvironment('ADMOB_APP_ID',
    defaultValue: 'ca-app-pub-3940256099942544~3347511713');
const String kAdMobBannerAdUnitId = String.fromEnvironment(
    'ADMOB_BANNER_AD_UNIT_ID',
    defaultValue: 'ca-app-pub-3940256099942544/2934735716');
const String kAdMobInterstitialAdUnitId = String.fromEnvironment(
    'ADMOB_INTERSTITIAL_AD_UNIT_ID',
    defaultValue: 'ca-app-pub-3940256099942544/4411468910');
```

### 2. Configuration Files
For non-sensitive configurations, we use a configuration file:
```dart
// lib/config/app_config.dart
class AppConfig {
  // Feature flags
  static const bool enablePremiumFeatures =
      bool.fromEnvironment('ENABLE_PREMIUM', defaultValue: true);
  static const bool enableAds =
      bool.fromEnvironment('ENABLE_ADS', defaultValue: true);
  static const bool enableInAppPurchase = true;

  // App info
  static const String appName = 'JayJay';
  static const String version = '1.0.0';
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;

  // Service limits
  static const int maxRequestsPerDay = 10;
  static const int maxStorageMB = 100;
  static const int maxHistoryItems = 50;

  // Premium features
  static const List<String> premiumFeatureKeys = [
    'featureNoAds',
    'featureUnlimitedRequests',
    'featureUnlimitedStorage',
    'featureUnlimitedHistory',
    'featureAdvancedFeatures',
  ];

  // In-App Purchase configuration
  static const String premiumMonthlyId = 'com.jayjay.premium.monthly';
  static const String premiumYearlyId = 'com.jayjay.premium.yearly';
}
```

### 3. Build Configuration
Different configurations for different environments:
```yaml
# flutter build configuration
flutter:
  build:
    debug:
      environment:
        ADMOB_APP_ID: "ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"
        ADMOB_BANNER_AD_UNIT_ID: "ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy"
        ADMOB_INTERSTITIAL_AD_UNIT_ID: "ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy"
    release:
      environment:
        ADMOB_APP_ID: "ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"
        ADMOB_BANNER_AD_UNIT_ID: "ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy"
        ADMOB_INTERSTITIAL_AD_UNIT_ID: "ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyy"
```

## Technology Stack

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  # Database
  sqflite: ^2.3.0
  path: ^1.8.3
  # In-App Purchase
  in_app_purchase: ^3.1.11
  # Advertising
  google_mobile_ads: ^4.0.0
  # Utilities
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  intl: ^0.18.1
  package_info_plus: ^5.0.1
  # Localization
  flutter_localizations:
    sdk: flutter
```

## Project Structure

```
lib/
├── config/          # Configuration files
├── l10n/           # Localization files
├── models/         # Data Models
├── services/       # Service Layer
│   ├── core/      # Core Services (ServiceFactory)
│   ├── storage/   # Storage Services
│   ├── rules/     # Business Rules
│   ├── premium/   # Premium Features
│   ├── ad/        # Ad Management
│   ├── theme/     # Theme Management
│   ├── language/  # Language Management
│   └── user/      # User Management
├── screens/        # Screens
│   ├── home/      # Home Screen
│   ├── premium/   # Premium Features Screen
│   ├── profile/   # User Profile Screen
│   ├── settings/  # Settings Screen
│   └── features/  # Feature Screens
├── widgets/        # Reusable Components
└── utils/         # Utilities
```

## Core Feature Implementation

### 1. Service Layer Architecture

The service layer uses the factory pattern for dependency injection:

```dart
class ServiceFactory {
  static final ServiceFactory _instance = ServiceFactory._internal();
  factory ServiceFactory() => _instance;
  ServiceFactory._internal();

  // Core services
  late final StorageService storageService;
  late final UserRules _userRules;
  late final UserService _userService;
  late final ThemeService _themeService;
  late final LanguageService _languageService;
  late final DatabaseHelper _databaseHelper;

  // Optional services
  late final PremiumService _premiumService;
  late final AdManager? _adManager;
  late final BusinessService _businessService;

  static Future<void> initialize() async {
    // Initialize services in correct order
  }
}
```

### 2. Database Implementation

Using SQLite for local data storage with proper initialization order:

```dart
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  late final Database _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    // Database initialization logic
  }
}
```

### 3. In-App Purchase

Premium service implementation with expiration date support:

```dart
class PremiumService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late final UserRules _userRules;
  
  bool get isPremium => _isPremium;
  DateTime? get expireDate => _expireDate;

  Future<void> initialize() async {
    // Initialize purchase state
    _isPremium = await _userRules.isPremium();
    final expireDateStr = await _userRules.getPremiumExpireDate();
    if (expireDateStr.isNotEmpty) {
      _expireDate = DateTime.parse(expireDateStr);
    }
  }
}
```

### 4. User Rules

Business rules implementation with premium features:

```dart
class UserRules {
  final StorageService _storage = StorageService();

  Future<bool> isPremium() async {
    return await _storage.getBool('is_premium') ?? false;
  }

  Future<void> setPremium(bool value) async {
    await _storage.setBool('is_premium', value);
  }

  Future<String> getPremiumExpireDate() async {
    return await _storage.getString(_premiumExpireDateKey) ?? '';
  }

  Future<void> setPremiumExpireDate(String date) async {
    await _storage.setString(_premiumExpireDateKey, date);
  }
}
```

## UI Implementation

### 1. Localization Support

Using ARB files for localization:

```arb
// app_en.arb
{
  "appTitle": "JayJay",
  "appDescription": "A powerful app for your needs",
  "premiumStatus": "Premium Status",
  "premiumBenefits": "Unlock all features and remove ads",
  "upgradeNow": "Upgrade Now",
  "expireDate": "Expire Date"
}
```

### 2. Theme Management

Theme service implementation:

```dart
class ThemeService extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
```

## Best Practices

### 1. Service Initialization Order

Proper service initialization order is crucial:
1. Database initialization
2. Core services initialization
3. Optional services initialization
4. Business services initialization

### 2. Error Handling

Unified error handling with proper logging:

```dart
try {
  // Service operation
} catch (e) {
  debugPrint('Error: $e');
  // Handle error appropriately
}
```

### 3. State Management

Using Provider for state management with proper service integration:

```dart
class AppState extends ChangeNotifier {
  final UserService _userService = UserService();
  
  Future<bool> get isPremium async => await _userService.isPremium();
  
  Future<void> updatePremiumStatus(bool status) async {
    await _userService.setPremium(status);
    notifyListeners();
  }
}
```

## Project Configuration

### 1. Android Configuration

Add necessary permissions in `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="com.android.vending.BILLING"/>
    <application>
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
    </application>
</manifest>
```

### 2. iOS Configuration

Add necessary configurations in `ios/Runner/Info.plist`:

```xml
<dict>
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
    <key>SKPaymentTransactionObserverEverywhere</key>
    <true/>
</dict>
```

## Quick Start

1. Clone the project
2. Update configuration in `lib/config/app_config.dart`
3. Configure ad IDs and in-app purchase products
4. Initialize services in correct order
5. Run the project

## Important Notes

1. Ensure proper service initialization order
2. Handle premium status and expiration date correctly
3. Implement proper error handling
4. Follow Flutter performance optimization recommendations

## Debugging Tips

1. Use Flutter DevTools for performance analysis
2. Enable ad test mode
3. Use in-app purchase test accounts
4. Monitor service initialization logs

## Release Checklist

- [ ] Update version number
- [ ] Replace test ad IDs
- [ ] Configure production in-app purchase
- [ ] Complete privacy policy and user agreement
- [ ] Prepare App Store and Play Store release materials
- [ ] Test all payment scenarios
- [ ] Verify ad display
- [ ] Check service initialization

## Contribution Guide

1. Follow Flutter official code style recommendations
2. Maintain proper service initialization order
3. Keep documentation up to date
4. Follow semantic versioning

## License

MIT License 