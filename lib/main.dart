import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jayjay_starter/config/app_config.dart';
import 'package:jayjay_starter/config/routes.dart';
import 'package:jayjay_starter/services/core/service_factory.dart';
import 'package:jayjay_starter/services/theme/theme_service.dart';
import 'package:jayjay_starter/services/language/language_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jayjay_starter/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceFactory.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceFactory.themeService),
        ChangeNotifierProvider(create: (_) => ServiceFactory.languageService),
      ],
      child: Consumer2<ThemeService, LanguageService>(
        builder: (context, themeService, languageService, _) {
          return MaterialApp(
            title: AppLocalizations.of(context)?.appTitle ?? 'JayJay Starter',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeService.themeMode,
            locale: Locale(languageService.currentLanguage),
            supportedLocales: const [
              Locale('zh'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
