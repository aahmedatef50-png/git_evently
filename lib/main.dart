import 'package:evently_app/Ui/home/home_screen.dart';
import 'package:evently_app/Ui/home/login/login_screen.dart';
import 'package:evently_app/Ui/home/register/register_screen.dart';
import 'package:evently_app/Ui/home/tabs/home/add_event/add_event_screen.dart';
import 'package:evently_app/Ui/on_boarding/introduction_screen.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AppThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homescreen,
      routes: {AppRoutes.introductionScreen: (context) => OnboardingScreen(),
        AppRoutes.homescreen: (context) => HomeScreen(),
        AppRoutes.login_screen: (context) => LoginScreen(),
        AppRoutes.register_screen: (context) => RegisterScreen(),
        AppRoutes.add_event_screen: (context) => AddEventScreen(),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
