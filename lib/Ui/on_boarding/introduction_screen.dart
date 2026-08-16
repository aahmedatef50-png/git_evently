import 'package:evently_app/Ui/on_boarding/widgets/Language_button.dart';
import 'package:evently_app/Ui/on_boarding/widgets/theme_button.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              themeProvider.appTheme == ThemeMode.light
                  ? AppAssets.onboarding_light
                  : AppAssets.onboarding_dark,
            ),
            Expanded(
              child: IntroductionScreen(
                showDoneButton: true,
                done: Text(
                  AppLocalizations.of(context)!.getStarted,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                onDone: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.login_screen);
                },
                showBackButton: true,
                back: Text(
                  AppLocalizations.of(context)!.back,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                showNextButton: true,
                next: Text(
                  AppLocalizations.of(context)!.next,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                pages: [
                  PageViewModel(
                    titleWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingTitle1,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    image: Image.asset(
                      themeProvider.appTheme == ThemeMode.light
                          ? AppAssets.onboarding_1_light
                          : AppAssets.onboarding_1_dark,
                    ),
                    decoration: PageDecoration(imageFlex: 3, bodyFlex: 2),
                    bodyWidget: Column(
                      spacing: 20,
                      children: [
                        Align(
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.onboardingDescription1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          spacing: 15,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Spacer(),
                            LanguageButton(
                              onPressed: () {
                                languageProvider.changeLanguage('en');
                              },
                              text: AppLocalizations.of(context)!.english,
                              selected: languageProvider.appLanguage == 'en',
                            ),

                            LanguageButton(
                              onPressed: () {
                                languageProvider.changeLanguage('ar');
                              },
                              text: AppLocalizations.of(context)!.arabic,
                              selected: languageProvider.appLanguage == 'ar',
                            ),
                          ],
                        ),
                        Row(
                          spacing: 15,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.theme,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Spacer(),
                            ThemeButton(
                              onPressed: () {
                                themeProvider.changeTheme(ThemeMode.light);
                              },
                              icon: Icons.light_mode,
                              selected:
                                  themeProvider.appTheme == ThemeMode.light,
                            ),
                            ThemeButton(
                              onPressed: () {
                                themeProvider.changeTheme(ThemeMode.dark);
                              },
                              icon: Icons.dark_mode_outlined,
                              selected:
                                  themeProvider.appTheme == ThemeMode.dark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PageViewModel(
                    titleWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingTitle2,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    bodyWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingDescription2,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    image: Image.asset(
                      themeProvider.appTheme == ThemeMode.light
                          ? AppAssets.onboarding_2_light
                          : AppAssets.onboarding_2_dark,
                    ),
                    decoration: PageDecoration(imageFlex: 3, bodyFlex: 2),
                  ),
                  PageViewModel(
                    titleWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingTitle3,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    bodyWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingDescription3,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    image: Image.asset(
                      themeProvider.appTheme == ThemeMode.light
                          ? AppAssets.onboarding_3_light
                          : AppAssets.onboarding_3_dark,
                    ),
                    decoration: PageDecoration(imageFlex: 3, bodyFlex: 2),
                  ),
                  PageViewModel(
                    titleWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingTitle4,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    bodyWidget: Align(
                      child: Text(
                        AppLocalizations.of(context)!.onboardingDescription4,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    image: Image.asset(
                      themeProvider.appTheme == ThemeMode.light
                          ? AppAssets.onboarding_4_light
                          : AppAssets.onboarding_4_dark,
                    ),
                    decoration: PageDecoration(imageFlex: 3, bodyFlex: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
