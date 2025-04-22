import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'en';
  
  late SharedPreferences _prefs;
  String _currentLanguage = _defaultLanguage;

  String get currentLanguage => _currentLanguage;
  
  LanguageService() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _currentLanguage = _prefs.getString(_languageKey) ?? _defaultLanguage;
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      await _prefs.setString(_languageKey, languageCode);
      notifyListeners();
    }
  }

  static const Map<String, String> languageNames = {
    'zh': '简体中文',
    'en': 'English',
  };
} 