class AppConfig {
  // Feature flags
  static const bool enablePremium = bool.fromEnvironment('ENABLE_PREMIUM', defaultValue: true);
  static const bool enableAds = bool.fromEnvironment('ENABLE_ADS', defaultValue: true);
  static const bool enableInAppPurchase = true;
  
  // App info
  static const String appName = 'JayJay Starter';
  static const String version = '1.0.0';
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;
  
  // API endpoints
  static const String apiBaseUrl = 'https://api.example.com';
  
  // Database configuration
  static const String dbName = 'jayjay_starter.db';
  static const int dbVersion = 1;
  
  // AdMob configuration
  static const String adMobAppId = String.fromEnvironment('ADMOB_APP_ID', defaultValue: 'ca-app-pub-3940256099942544~3347511713');
  static const String adMobBannerId = String.fromEnvironment('ADMOB_BANNER_AD_UNIT_ID', defaultValue: 'ca-app-pub-3940256099942544/2934735716');
  static const String adMobInterstitialAdUnitId = String.fromEnvironment('ADMOB_INTERSTITIAL_AD_UNIT_ID', defaultValue: 'ca-app-pub-3940256099942544/4411468910');
  
  // In-App Purchase configuration
  static const List<String> productIds = [
    'com.example.jayjay.premium',
    'com.example.jayjay.remove_ads',
  ];

  // 广告配置
  static const int adInterval = 3; // 广告显示间隔（分钟）

  // 服务限制配置
  static const int maxRequestsPerDay = 10;
  static const int maxStorageMB = 100; // 最大存储空间（MB）
  static const int maxHistoryItems = 50; // 最大历史记录数量

  // 付费功能配置
  static const List<String> premiumFeatureKeys = [
    'featureNoAds',
    'featureUnlimitedRequests',
    'featureUnlimitedStorage',
    'featureUnlimitedHistory',
    'featureAdvancedFeatures',
  ];

  // 价格配置
  static const double monthlyPrice = 9.99;
  static const double yearlyPrice = 99.99;
  static const double lifetimePrice = 199.99;

  // 应用内购买商品 ID
  static const String premiumMonthlyId = 'com.jayjay.premium.monthly';
  static const String premiumYearlyId = 'com.jayjay.premium.yearly';
} 