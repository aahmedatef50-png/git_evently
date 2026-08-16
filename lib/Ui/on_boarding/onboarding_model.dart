import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/app_assets.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingModel> getPages(BuildContext context) {
  return [
    OnBoardingModel(
      image: AppAssets.onboarding_2_light,
      title: AppLocalizations.of(context)!.onboardingTitle1,
      description: AppLocalizations.of(context)!.onboardingDescription1,
    ),
    OnBoardingModel(
      image: AppAssets.onboarding_3_light,
      title: AppLocalizations.of(context)!.onboardingTitle2,
      description: AppLocalizations.of(context)!.onboardingDescription2,
    ),
    OnBoardingModel(
      image: AppAssets.onboarding_4_light,
      title: AppLocalizations.of(context)!.onboardingTitle4,
      description: AppLocalizations.of(context)!.onboardingDescription4,
    ),
  ];
}
