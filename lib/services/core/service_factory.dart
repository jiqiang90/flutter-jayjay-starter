import 'package:flutter/foundation.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/services/ad/ad_manager.dart';
import 'package:jayjay_starter/services/premium/premium_service.dart';
import 'package:jayjay_starter/services/rules/user_rules.dart';
import 'package:jayjay_starter/services/storage/storage_service.dart';
import 'package:jayjay_starter/services/user/user_service.dart';
import 'package:jayjay_starter/services/theme/theme_service.dart';
import 'package:jayjay_starter/services/language/language_service.dart';
import 'package:jayjay_starter/services/business/business_service.dart';
import 'package:jayjay_starter/services/database/database_helper.dart';

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
    try {
      // Initialize database
      _instance._databaseHelper = DatabaseHelper();
      await _instance._databaseHelper.database;

      // Initialize core services
      _instance.storageService = StorageService();
      await _instance.storageService.initialize();

      _instance._userRules = UserRules();
      await _instance._userRules.initialize();

      _instance._userService = UserService();
      await _instance._userService.initialize();

      _instance._themeService = ThemeService();
      await _instance._themeService.initialize();

      _instance._languageService = LanguageService();

      // Initialize optional services based on configuration
      if (AppConfig.enablePremiumFeatures) {
        _instance._premiumService = PremiumService(_instance._userRules);
      }

      if (AppConfig.enableAds) {
        _instance._adManager = AdManager();
        await _instance._adManager?.initialize();
      }

      // Initialize business services
      _instance._businessService = BusinessService(_instance._databaseHelper);
      await _instance._businessService?.initialize();

      debugPrint('ServiceFactory initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize ServiceFactory: $e');
      rethrow;
    }
  }

  // Helper method to get services
  static StorageService get storage => _instance.storageService;
  static UserRules get userRules => _instance._userRules;
  static UserService get userService => _instance._userService;
  static ThemeService get themeService => _instance._themeService;
  static PremiumService? get premiumService => _instance._premiumService;
  static AdManager? get adManager => _instance._adManager;
  static LanguageService get languageService => _instance._languageService;
  static BusinessService get businessService => _instance._businessService!;
}
