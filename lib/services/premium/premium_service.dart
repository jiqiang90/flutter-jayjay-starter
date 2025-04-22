import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/services/rules/user_rules.dart';

class PremiumService {
  static final PremiumService _instance = PremiumService._internal();
  factory PremiumService(UserRules userRules) {
    _instance._userRules = userRules;
    return _instance;
  }
  PremiumService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final StreamController<List<PurchaseDetails>> _purchaseController =
      StreamController<List<PurchaseDetails>>.broadcast();
  Stream<List<PurchaseDetails>> get purchaseStream =>
      _purchaseController.stream;

  bool _isInitialized = false;
  bool _isPremium = false;
  DateTime? _expireDate;
  List<ProductDetails> _products = [];
  late final UserRules _userRules;

  bool get isPremium => _isPremium;

  DateTime? get expireDate => _expireDate;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize purchase state
      _isPremium = await _userRules.isPremium();
      final expireDateStr = await _userRules.getPremiumExpireDate();
      if (expireDateStr.isNotEmpty) {
        _expireDate = DateTime.parse(expireDateStr);
      }

      // Set up purchase listener
      final Stream<List<PurchaseDetails>> purchaseUpdated =
          _inAppPurchase.purchaseStream;
      purchaseUpdated.listen((purchases) {
        _handlePurchases(purchases);
        _purchaseController.add(purchases);
      });

      // Load products
      await _loadProducts();

      _isInitialized = true;
      debugPrint('PremiumService initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize PremiumService: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails({
        AppConfig.premiumMonthlyId,
        AppConfig.premiumYearlyId,
      });

      if (response.notFoundIDs.isNotEmpty) {
        debugPrint('Products not found: ${response.notFoundIDs}');
      }

      _products = response.productDetails;
      debugPrint('Products loaded: ${_products.length}');
    } catch (e) {
      debugPrint('Failed to load products: $e');
    }
  }

  Future<bool> purchasePremium(String plan) async {
    try {
      final productId = plan == 'monthly'
          ? AppConfig.premiumMonthlyId
          : AppConfig.premiumYearlyId;
      final product = _products.firstWhere((p) => p.id == productId);

      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product,
      );

      final bool success =
          await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      return success;
    } catch (e) {
      debugPrint('Failed to purchase premium: $e');
      return false;
    }
  }

  Future<void> _handlePurchases(List<PurchaseDetails> purchases) async {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        await _verifyPurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
        debugPrint('Purchase error: ${purchase.error}');
      }

      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    try {
      // TODO: Add server verification logic here
      // Currently we only do local verification
      await _userRules.setPremium(true);

      // Set expiration date
      final now = DateTime.now();
      final expireDate = purchase.productID == AppConfig.premiumMonthlyId
          ? now.add(const Duration(days: 30))
          : now.add(const Duration(days: 365));

      await _userRules.setPremiumExpireDate(expireDate.toIso8601String());

      _isPremium = true;
      _expireDate = expireDate;

      debugPrint('Purchase verified successfully');
    } catch (e) {
      debugPrint('Failed to verify purchase: $e');
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _inAppPurchase.restorePurchases();
      debugPrint('Purchases restored');
    } catch (e) {
      debugPrint('Failed to restore purchases: $e');
    }
  }

  void dispose() {
    _purchaseController.close();
  }
}
