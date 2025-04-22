import 'package:flutter/material.dart';
import 'package:jayjay_starter/config/routes.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class UpgradePremiumSheet extends StatelessWidget {
  final String message;
  final VoidCallback? onUpgradePressed;

  const UpgradePremiumSheet({
    super.key,
    required this.message,
    this.onUpgradePressed,
  });

  static Future<void> show(
    BuildContext context, {
    required String message,
    VoidCallback? onUpgradePressed,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => UpgradePremiumSheet(
        message: message,
        onUpgradePressed: onUpgradePressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.premiumUpgradeTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              // 会员权益列表
              Column(
                children: [
                  _buildFeatureItem(
                    context,
                    icon: Icons.block,
                    text: l10n.premiumFeatureNoAds,
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.all_inclusive,
                    text: l10n.premiumFeatureUnlimitedRequests,
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.storage,
                    text: l10n.premiumFeatureUnlimitedStorage,
                  ),
                  _buildFeatureItem(
                    context,
                    icon: Icons.star,
                    text: l10n.premiumFeatureAdvanced,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onUpgradePressed != null) {
                    onUpgradePressed!();
                  } else {
                    Navigator.of(context).pushNamed(AppRoutes.premium);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(l10n.premiumUpgradeButton),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
} 