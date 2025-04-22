class PremiumConfig {
  static const List<String> premiumFeatures = [
    'Advanced Statistics',
    'Custom Themes',
    'Export Data',
    'Priority Support',
  ];

  // Product IDs for in-app purchases
  static const String monthlyProductId = 'com.jayjay.starter.premium.monthly';
  static const String yearlyProductId = 'com.jayjay.starter.premium.yearly';
  static const String lifetimeProductId = 'com.jayjay.starter.premium.lifetime';

  // Default prices (will be updated with actual prices from store)
  static const double monthlyPrice = 4.99;
  static const double yearlyPrice = 49.99;
  static const double lifetimePrice = 99.99;

  static const String premiumStorageKey = 'is_premium';
} 