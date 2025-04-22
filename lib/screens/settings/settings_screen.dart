import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/services/theme/theme_service.dart';
import 'package:jayjay_starter/services/language/language_service.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _isPremium = false;
  DateTime? _expireDate;

  @override
  void initState() {
    super.initState();
    _loadPremiumStatus();
  }

  Future<void> _loadPremiumStatus() async {
    final premiumService = ServiceFactory.premiumService;
    if (premiumService != null) {
      setState(() {
        _isPremium = premiumService.isPremium;
        _expireDate = premiumService.expireDate;
      });
    }
  }

  String _formatExpireDate() {
    if (_expireDate == null) return '';
    return '${_expireDate!.year}-${_expireDate!.month.toString().padLeft(2, '0')}-${_expireDate!.day.toString().padLeft(2, '0')}';
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Consumer<ThemeService>(
        builder: (context, themeService, _) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.themeSettings),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(AppLocalizations.of(context)!.lightMode),
                  value: ThemeMode.light,
                  groupValue: themeService.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      themeService.setThemeMode(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: Text(AppLocalizations.of(context)!.darkMode),
                  value: ThemeMode.dark,
                  groupValue: themeService.themeMode,
                  onChanged: (ThemeMode? value) {
                    if (value != null) {
                      themeService.setThemeMode(value);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Consumer<LanguageService>(
        builder: (context, languageService, _) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.languageSettings),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('简体中文'),
                  trailing: languageService.currentLanguage == 'zh'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    languageService.setLanguage('zh');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('English'),
                  trailing: languageService.currentLanguage == 'en'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    languageService.setLanguage('en');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.aboutApp),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                '${AppLocalizations.of(context)!.version} ${AppConfig.version}'),
            const SizedBox(height: 16),
            ListTile(
              title: Text(AppLocalizations.of(context)!.checkUpdates),
              onTap: () {
                // TODO: 检查更新
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.privacyPolicy),
              onTap: () {
                // TODO: 显示隐私政策
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.userAgreement),
              onTap: () {
                // TODO: 显示用户协议
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(
              Icons.star,
              color: _isPremium ? Colors.amber : Colors.grey,
            ),
            title: Text(_isPremium
                ? AppLocalizations.of(context)!.premium
                : AppLocalizations.of(context)!.upgradeToPremium),
            subtitle: Text(
              _isPremium
                  ? '${AppLocalizations.of(context)!.premiumStatus}\n${AppLocalizations.of(context)!.expireDate}: ${_formatExpireDate()}'
                  : AppLocalizations.of(context)!.premiumBenefits,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            trailing: _isPremium
                ? Text(
                    AppLocalizations.of(context)!.premium,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () => _navigateToPremium(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(AppLocalizations.of(context)!.upgradeNow),
                  ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text(AppLocalizations.of(context)!.themeSettings),
            subtitle: Consumer<ThemeService>(
              builder: (context, themeService, _) => Text(
                themeService.themeMode == ThemeMode.light
                    ? AppLocalizations.of(context)!.lightMode
                    : AppLocalizations.of(context)!.darkMode,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ),
            onTap: () => _showThemeDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(AppLocalizations.of(context)!.notificationSettings),
            subtitle: Text(
              _notifications
                  ? AppLocalizations.of(context)!.notificationsEnabled
                  : AppLocalizations.of(context)!.notificationsDisabled,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            trailing: Switch(
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.languageSettings),
            subtitle: Consumer<LanguageService>(
              builder: (context, languageService, _) => Text(
                LanguageService
                        .languageNames[languageService.currentLanguage] ??
                    '简体中文',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(AppLocalizations.of(context)!.aboutApp),
            subtitle: Text(
                '${AppLocalizations.of(context)!.version} ${AppConfig.version}'),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  void _navigateToPremium(BuildContext context) {
    Navigator.pushNamed(context, '/premium').then((_) {
      _loadPremiumStatus();
    });
  }
}
