import 'package:flutter/foundation.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/services/storage/storage_service.dart';

class UserRules {
  static final UserRules _instance = UserRules._internal();
  factory UserRules() => _instance;
  UserRules._internal();

  final StorageService _storage = StorageService();

  Future<void> initialize() async {
    await _storage.initialize();
  }

  Future<bool> canMakeRequest() async {
    final int requestCount = await _storage.getInt('request_count') ?? 0;
    return requestCount < AppConfig.maxRequestsPerDay;
  }

  Future<void> incrementRequestCount() async {
    final int requestCount = await _storage.getInt('request_count') ?? 0;
    await _storage.setInt('request_count', requestCount + 1);
  }

  Future<void> resetRequestCount() async {
    await _storage.setInt('request_count', 0);
  }

  Future<int> getRequestCount() async {
    return await _storage.getInt('request_count') ?? 0;
  }

  Future<bool> canAddHistoryItem() async {
    final int historyCount = await _storage.getInt('history_count') ?? 0;
    return historyCount < AppConfig.maxHistoryItems;
  }

  Future<void> incrementHistoryCount() async {
    final int historyCount = await _storage.getInt('history_count') ?? 0;
    await _storage.setInt('history_count', historyCount + 1);
  }

  Future<void> decrementHistoryCount() async {
    final int historyCount = await _storage.getInt('history_count') ?? 0;
    if (historyCount > 0) {
      await _storage.setInt('history_count', historyCount - 1);
    }
  }

  Future<void> resetHistoryCount() async {
    await _storage.setInt('history_count', 0);
  }

  Future<bool> canAddStorage(int sizeInMB) async {
    final int currentSize = await _storage.getInt('storage_size') ?? 0;
    return currentSize + sizeInMB <= AppConfig.maxStorageMB;
  }

  Future<void> incrementStorageSize(int sizeInMB) async {
    final int currentSize = await _storage.getInt('storage_size') ?? 0;
    await _storage.setInt('storage_size', currentSize + sizeInMB);
  }

  Future<void> decrementStorageSize(int sizeInMB) async {
    final int currentSize = await _storage.getInt('storage_size') ?? 0;
    if (currentSize >= sizeInMB) {
      await _storage.setInt('storage_size', currentSize - sizeInMB);
    }
  }

  Future<void> resetStorageSize() async {
    await _storage.setInt('storage_size', 0);
  }

  Future<int> getStorageSize() async {
    return await _storage.getInt('storage_size') ?? 0;
  }

  Future<int> getHistoryCount() async {
    return await _storage.getInt('history_count') ?? 0;
  }

  Future<bool> isPremium() async {
    return await _storage.getBool('is_premium') ?? false;
  }

  Future<void> setPremium(bool value) async {
    await _storage.setBool('is_premium', value);
  }

  static const String _premiumExpireDateKey = 'premium_expire_date';

  Future<String> getPremiumExpireDate() async {
    return await _storage.getString(_premiumExpireDateKey) ?? '';
  }

  Future<void> setPremiumExpireDate(String date) async {
    await _storage.setString(_premiumExpireDateKey, date);
  }
}
