import 'package:flutter/material.dart';
import 'package:jayjay_starter/config/routes.dart';

class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final args = route.settings.arguments as Map<String, dynamic>?;
    final isPremium = args?[AppRoutes.paramIsPremium] ?? false;
    
    // Log route changes
    print('Route pushed: ${route.settings.name} (Premium: $isPremium)');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    print('Route popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final args = newRoute?.settings.arguments as Map<String, dynamic>?;
    final isPremium = args?[AppRoutes.paramIsPremium] ?? false;
    
    print('Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name} (Premium: $isPremium)');
  }
} 