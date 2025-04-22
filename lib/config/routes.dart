import 'package:flutter/material.dart';
import 'package:jayjay_starter/screens/main_screen.dart';
import 'package:jayjay_starter/screens/home/home_screen.dart';
import 'package:jayjay_starter/screens/settings/settings_screen.dart';
import 'package:jayjay_starter/screens/features/business_test_screen.dart';
import 'package:jayjay_starter/screens/profile/profile_screen.dart';
import 'package:jayjay_starter/screens/premium/premium_screen.dart';

class AppRoutes {
  // Main routes
  static const String initial = '/';
  static const String main = '/main';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String premium = '/premium';
  static const String businessTest = '/business-test';

  // Route parameters
  static const String paramFeatureId = 'featureId';
  static const String paramIsPremium = 'isPremium';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/premium':
        return MaterialPageRoute(builder: (_) => const PremiumScreen());
      case '/business-test':
        return MaterialPageRoute(builder: (_) => const BusinessTestScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
