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

  // 核心服务
  late final StorageService storageService;
  late final UserRules _userRules;
  late final UserService _userService;
  late final ThemeService _themeService;
  late final LanguageService _languageService;
  late final DatabaseHelper _databaseHelper;

  // 可选服务
  PremiumService? _premiumService;
  AdManager? _adManager;
  BusinessService? _businessService;

  static Future<void> initialize() async {
    try {
      // 初始化数据库
      _instance._databaseHelper = DatabaseHelper();
      await _instance._databaseHelper.database;

      // 初始化核心服务
      _instance.storageService = StorageService();
      await _instance.storageService.initialize();

      _instance._userRules = UserRules();
      await _instance._userRules.initialize();

      _instance._userService = UserService();
      await _instance._userService.initialize();

      _instance._themeService = ThemeService();
      await _instance._themeService.initialize();

      _instance._languageService = LanguageService();

      // 根据配置初始化可选服务
      if (AppConfig.enablePremium) {
        _instance._premiumService = PremiumService();
        await _instance._premiumService?.initialize();
      }

      if (AppConfig.enableAds) {
        _instance._adManager = AdManager();
        await _instance._adManager?.initialize();
      }

      // 初始化业务服务
      _instance._businessService = BusinessService();
      await _instance._businessService?.initialize();

      debugPrint('ServiceFactory initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize ServiceFactory: $e');
      rethrow;
    }
  }

  // 获取服务的辅助方法
  static StorageService get storage => _instance.storageService;
  static UserRules get userRules => _instance._userRules;
  static UserService get userService => _instance._userService;
  static ThemeService get themeService => _instance._themeService;
  static PremiumService? get premiumService => _instance._premiumService;
  static AdManager? get adManager => _instance._adManager;
  static LanguageService get languageService => _instance._languageService;
  static BusinessService get businessService => _instance._businessService!;
} 