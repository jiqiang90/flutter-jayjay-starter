import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jayjay_starter/config/app_config.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  
  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      debugPrint('MobileAds initialized successfully');
      _loadBannerAd();
      _loadInterstitialAd();
    } catch (e) {
      debugPrint('Failed to initialize MobileAds: $e');
    }
  }

  void _loadBannerAd() {
    try {
      _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AppConfig.adMobBannerId,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            debugPrint('Banner ad loaded successfully');
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            debugPrint('Banner ad failed to load: $error');
          },
        ),
      );

      _bannerAd?.load();
    } catch (e) {
      debugPrint('Failed to load banner ad: $e');
    }
  }

  void _loadInterstitialAd() {
    try {
      InterstitialAd.load(
        adUnitId: AppConfig.adMobInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            debugPrint('Interstitial ad loaded successfully');
          },
          onAdFailedToLoad: (error) {
            debugPrint('Interstitial ad failed to load: $error');
          },
        ),
      );
    } catch (e) {
      debugPrint('Failed to load interstitial ad: $e');
    }
  }

  BannerAd? get bannerAd => _bannerAd;

  Future<void> showInterstitialAd() async {
    if (_interstitialAd == null) {
      debugPrint('Interstitial ad not loaded');
      return;
    }

    try {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _loadInterstitialAd();
        },
      );

      await _interstitialAd!.show();
      _interstitialAd = null;
    } catch (e) {
      debugPrint('Failed to show interstitial ad: $e');
    }
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
} 