import 'package:flutter/material.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/screens/home/home_screen.dart';
import 'package:jayjay_starter/screens/features/business_test_screen.dart';
import 'package:jayjay_starter/screens/profile/profile_screen.dart';
import 'package:jayjay_starter/screens/settings/settings_screen.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/widgets/ads/ad_banner.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BusinessTestScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = ServiceFactory.premiumService?.isPremium ?? false;
    final showAds = AppConfig.enableAds && !isPremium;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _screens[_selectedIndex],
          ),
          if (showAds)
            const AdBanner(
              size: AdSize.banner,
              margin: EdgeInsets.only(bottom: 8),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.science_outlined),
            selectedIcon: const Icon(Icons.science),
            label: l10n.test,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
} 