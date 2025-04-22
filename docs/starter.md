# JayJay Starter: A Flutter Application Development Starter

## Project Overview

This is a Flutter application development starter template that integrates the following core features:
- In-App Purchase
- Google AdMob Advertising
- Local Database Storage
- Service Layer Architecture
- UI Component Library

## Configuration Management

### 1. Environment Variables
The project uses environment variables for sensitive configurations:
```dart
// Example of environment variables
const String kAdMobAppId = String.fromEnvironment('ADMOB_APP_ID');
const String kAdMobBannerAdUnitId = String.fromEnvironment('ADMOB_BANNER_AD_UNIT_ID');
const String kAdMobInterstitialAdUnitId = String.fromEnvironment('ADMOB_INTERSTITIAL_AD_UNIT_ID');
```

### 2. Configuration Files
For non-sensitive configurations, we use a configuration file:
```dart
// lib/config/app_config.dart
class AppConfig {
  static const String appName = 'JayJay Starter';
  static const String version = '1.0.0';
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;
  
  // Feature flags
  static const bool enableAds = true;
  static const bool enableInAppPurchase = true;
  
  // API endpoints
  static const String apiBaseUrl = 'https://api.example.com';
  
  // Database configuration
  static const String dbName = 'jayjay_starter.db';
  static const int dbVersion = 1;
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
```

## Project Structure

```
lib/
├── models/          # Data Models
├── services/        # Service Layer
│   ├── core/       # Core Services
│   ├── storage/    # Storage Services
│   └── payment/    # Payment Services
├── screens/         # Screens
├── widgets/         # Reusable Components
├── utils/          # Utilities
└── data/           # Static Data
```

## Core Feature Implementation

### 1. Service Layer Architecture

The service layer uses the factory pattern for dependency injection and unit testing:

```dart
class ServiceFactory {
  static final ServiceFactory instance = ServiceFactory._internal();
  factory ServiceFactory() => instance;
  ServiceFactory._internal();

  late final PremiumService premiumService;
  late final AdManager adManager;
  late final StorageService storageService;
  
  Future<void> initialize() async {
    // Initialize services
  }
}
```

### 2. Database Implementation

Using SQLite for local data storage:

```dart
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Database initialization logic
  }
}
```

### 3. In-App Purchase

Integrating In-App Purchase functionality:

```dart
class PremiumService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  
  Future<void> initialize() async {
    // Initialize purchase service
  }

  Future<bool> buyProduct(String productId) async {
    // Purchase logic
  }
}
```

### 4. Ad Management

Google AdMob advertising integration:

```dart
class AdManager {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  
  Future<void> initialize() async {
    // Initialize ad service
  }

  Future<void> loadBannerAd() async {
    // Load banner ad
  }
}
```

## UI Component Library

### 1. Common Dialog

```dart
class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget>? actions,
  }) {
    // Dialog implementation
  }
}
```

### 2. Loading Indicator

```dart
class LoadingOverlay {
  static Future<T> show<T>({
    required BuildContext context,
    required Future<T> Function() asyncFunction,
  }) async {
    // Loading indicator implementation
  }
}
```

## Best Practices

### 1. Error Handling

Unified error handling mechanism:

```dart
class ExceptionHandler {
  static void handle(BuildContext context, dynamic error) {
    // Error handling logic
  }
}
```

### 2. State Management

Using Provider for state management:

```dart
class AppState extends ChangeNotifier {
  bool _isPremium = false;
  bool get isPremium => _isPremium;
  
  void updatePremiumStatus(bool status) {
    _isPremium = status;
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
    <!-- Other necessary permissions -->
</manifest>
```

### 2. iOS Configuration

Add necessary configurations in `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Ad-related configurations -->
    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
    <!-- In-App Purchase configurations -->
    <key>SKPaymentTransactionObserverEverywhere</key>
    <true/>
</dict>
```

## Quick Start

1. Clone the project template
2. Update project configuration (package name, version number, etc.)
3. Configure ad IDs and in-app purchase products
4. Initialize database structure
5. Run the project

## Important Notes

1. Ensure to replace all test ad IDs before release
2. Correctly configure in-app purchase product IDs
3. Implement appropriate data backup strategy
4. Follow Flutter performance optimization recommendations

## Debugging Tips

1. Use Flutter DevTools for performance analysis
2. Enable ad test mode
3. Use in-app purchase test accounts
4. Use database debugging tools

## Release Checklist

- [ ] Update version number
- [ ] Replace test ad IDs
- [ ] Configure production in-app purchase
- [ ] Complete privacy policy and user agreement
- [ ] Prepare App Store and Play Store release materials
- [ ] Test all payment scenarios
- [ ] Verify ad display
- [ ] Check database migration scripts

## Contribution Guide

1. Follow Flutter official code style recommendations
2. Perform unit tests before submission
3. Keep documentation up to date
4. Follow semantic versioning

## License

MIT License 