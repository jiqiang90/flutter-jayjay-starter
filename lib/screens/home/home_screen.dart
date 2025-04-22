import 'package:flutter/material.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
        actions: [
          if (AppConfig.enablePremiumFeatures)
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                // TODO: Show premium features page
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.appTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.appDescription,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          if (AppConfig.enablePremiumFeatures)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.premiumFeatures,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...AppConfig.premiumFeatureKeys.map((key) {
                      String text = '';
                      switch (key) {
                        case 'featureNoAds':
                          text = l10n.featureNoAds;
                          break;
                        case 'featureUnlimitedRequests':
                          text = l10n.featureUnlimitedRequests;
                          break;
                        case 'featureUnlimitedStorage':
                          text = l10n.featureUnlimitedStorage;
                          break;
                        case 'featureUnlimitedHistory':
                          text = l10n.featureUnlimitedHistory;
                          break;
                        case 'featureAdvancedFeatures':
                          text = l10n.featureAdvancedFeatures;
                          break;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(text),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.usageLimits,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${l10n.dailyRequests}: ${AppConfig.maxRequestsPerDay}'),
                  Text('${l10n.storageLimit}: ${AppConfig.maxStorageMB}MB'),
                  Text('${l10n.historyLimit}: ${AppConfig.maxHistoryItems}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
