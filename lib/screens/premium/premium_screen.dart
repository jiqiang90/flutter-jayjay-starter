import 'package:flutter/material.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/widgets/common/app_dialog.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _isLoading = false;

  Future<void> _handlePurchase(String plan) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final premiumService = ServiceFactory.premiumService;
      if (premiumService == null) {
        if (mounted) {
          await AppDialog.showError(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.purchaseServiceError,
          );
        }
        return;
      }

      final success = await premiumService.purchasePremium(plan);
      if (success) {
        if (mounted) {
          await AppDialog.showSuccess(
            context: context,
            title: AppLocalizations.of(context)!.purchaseSuccess,
            message: AppLocalizations.of(context)!.purchaseSuccessMessage,
          );
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          await AppDialog.showError(
            context: context,
            title: AppLocalizations.of(context)!.purchaseFailed,
            message: AppLocalizations.of(context)!.purchaseFailedMessage,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        await AppDialog.showError(
          context: context,
          title: AppLocalizations.of(context)!.purchaseFailed,
          message: '${AppLocalizations.of(context)!.purchaseFailedMessage}: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _restorePurchases() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final premiumService = ServiceFactory.premiumService;
      if (premiumService == null) {
        if (mounted) {
          await AppDialog.showError(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.purchaseServiceError,
          );
        }
        return;
      }

      await premiumService.restorePurchases();
      if (mounted) {
        await AppDialog.showSuccess(
          context: context,
          title: AppLocalizations.of(context)!.restoreSuccess,
          message: AppLocalizations.of(context)!.restoreSuccessMessage,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        await AppDialog.showError(
          context: context,
          title: AppLocalizations.of(context)!.restoreFailed,
          message: '${AppLocalizations.of(context)!.restoreFailedMessage}: $e',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(l10n.premiumPurchase),
            actions: [
              TextButton(
                onPressed: _isLoading ? null : _restorePurchases,
                child: Text(l10n.restorePurchases),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Icon(
                  Icons.star,
                  size: 80,
                  color: Colors.amber,
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.upgradeToPremium,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.premiumBenefits,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                _buildFeatureList(context),
                const SizedBox(height: 40),
                _buildPricingSection(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(l10n.loading),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          _FeatureItem(
            icon: Icons.check_circle_outline,
            text: l10n.featureUnlimitedRequests,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.block,
            text: l10n.featureNoAds,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.rocket_launch,
            text: l10n.featureEarlyAccess,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.support_agent,
            text: l10n.featurePrioritySupport,
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            l10n.choosePlan,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PricingCard(
                  title: l10n.monthlyPlan,
                  price: '¥9.9',
                  period: l10n.perMonth,
                  isPopular: false,
                  onTap: () => _handlePurchase('monthly'),
                  isLoading: _isLoading,
                  purchaseButtonText: l10n.purchaseNow,
                  popularLabel: l10n.mostPopular,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PricingCard(
                  title: l10n.yearlyPlan,
                  price: '¥99',
                  period: l10n.perYear,
                  isPopular: true,
                  onTap: () => _handlePurchase('yearly'),
                  isLoading: _isLoading,
                  purchaseButtonText: l10n.purchaseNow,
                  popularLabel: l10n.mostPopular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 16),
        Expanded(child: Text(text)),
      ],
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final bool isPopular;
  final VoidCallback onTap;
  final bool isLoading;
  final String purchaseButtonText;
  final String popularLabel;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.period,
    required this.isPopular,
    required this.onTap,
    required this.isLoading,
    required this.purchaseButtonText,
    required this.popularLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isPopular ? 4 : 2,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPopular)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    popularLabel,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              Text(
                period,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child: Text(purchaseButtonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
