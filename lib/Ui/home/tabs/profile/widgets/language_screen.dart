import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        backgroundColor: themeProvider.isDark()
            ? AppColors.mainLightColor
            : AppColors.transparentColor,
        iconTheme: IconThemeData(
          color: themeProvider.isDark()
              ? AppColors.mainDarkColor
              : AppColors.mainLightColor,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.english,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: languageProvider.appLanguage == 'en'
                ? Icon(
                    Icons.check,
                    color: themeProvider.isDark()
                        ? AppColors.mainLightColor
                        : AppColors.mainDarkColor,
                  )
                : null,
            onTap: () {
              languageProvider.changeLanguage('en');
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.arabic,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: languageProvider.appLanguage == 'ar'
                ? Icon(
                    Icons.check,
                    color: themeProvider.isDark()
                        ? AppColors.mainLightColor
                        : AppColors.mainDarkColor,
                  )
                : null,
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
          ),
        ],
      ),
    );
  }
}
