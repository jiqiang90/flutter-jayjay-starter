import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jayjay_starter/services/rules/user_rules.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  late final SharedPreferences _prefs;
  final UserRules _rules = UserRules();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User data management
  Future<void> saveUserData({
    required String name,
    required String email,
  }) async {
    await _prefs.setString('user_name', name);
    await _prefs.setString('user_email', email);
  }

  UserData? getUserData() {
    final name = _prefs.getString('user_name');
    final email = _prefs.getString('user_email');
    if (name == null || email == null) return null;
    return UserData(name: name, email: email);
  }

  String? getUserName() {
    return _prefs.getString('user_name');
  }

  String? getUserEmail() {
    return _prefs.getString('user_email');
  }

  bool isLoggedIn() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool('is_logged_in', value);
  }

  Future<void> clearUserData() async {
    await _prefs.remove('user_name');
    await _prefs.remove('user_email');
    await _prefs.remove('is_logged_in');
  }

  // User rules
  Future<bool> canMakeRequest() async {
    return await _rules.canMakeRequest();
  }

  Future<void> incrementRequestCount() async {
    await _rules.incrementRequestCount();
  }

  Future<bool> canAddHistoryItem() async {
    return await _rules.canAddHistoryItem();
  }

  Future<void> incrementHistoryCount() async {
    await _rules.incrementHistoryCount();
  }

  Future<void> decrementHistoryCount() async {
    await _rules.decrementHistoryCount();
  }

  Future<bool> canAddStorage(int sizeInMB) async {
    return await _rules.canAddStorage(sizeInMB);
  }

  Future<void> incrementStorageSize(int sizeInMB) async {
    await _rules.incrementStorageSize(sizeInMB);
  }

  Future<void> decrementStorageSize(int sizeInMB) async {
    await _rules.decrementStorageSize(sizeInMB);
  }

  // Usage tracking
  Future<void> incrementCounter(String key) async {
    final current = _prefs.getInt(key) ?? 0;
    await _prefs.setInt(key, current + 1);
  }

  Future<void> resetCounter(String key) async {
    await _prefs.setInt(key, 0);
  }

  // Usage statistics
  Future<Map<String, dynamic>> getUsageStats() async {
    return {
      'requestsToday': await _rules.getRequestCount(),
      'storageUsed': await _rules.getStorageSize(),
      'historyCount': await _rules.getHistoryCount(),
      'isPremium': await _rules.isPremium(),
    };
  }

  Future<bool> isPremium() async {
    return await _rules.isPremium();
  }

  Future<void> setPremium(bool value) async {
    await _rules.setPremium(value);
  }

  Future<DateTime?> getPremiumExpireDate() async {
    final dateStr = await _rules.getPremiumExpireDate();
    if (dateStr == null) return null;
    return DateTime.parse(dateStr);
  }

  Future<void> setPremiumExpireDate(DateTime date) async {
    await _rules.setPremiumExpireDate(date.toIso8601String());
  }

  Future<bool> isPremiumExpired() async {
    final expireDate = await getPremiumExpireDate();
    if (expireDate == null) return true;
    return DateTime.now().isAfter(expireDate);
  }
}

class UserData {
  final String name;
  final String email;

  UserData({
    required this.name,
    required this.email,
  });
} 