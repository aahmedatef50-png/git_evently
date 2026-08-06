import 'package:evently_app/Ui/home/tabs/profile/widgets/language_screen.dart';
import 'package:evently_app/Ui/home/tabs/profile/widgets/profile_item.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.06,
      ),
      child: SafeArea(
        child: Column(
          spacing: height * 0.02,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppAssets.logo_route),
            ),
            Text(
              "Route Academy",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "route@gmail.com",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            ProfileItem(
              text: AppLocalizations.of(context)!.darkmode,
              item: Switch(
                activeThumbColor: AppColors.whiteColor,
                inactiveThumbColor: AppColors.whiteColor,
                activeTrackColor: AppColors.mainDarkColor,
                inactiveTrackColor: AppColors.whiteDarkColor,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.transparentColor;
                  }
                  return AppColors.whiteColor; // Use the default color.
                }),
                value: themeProvider.isDark(),
                onChanged: (value) {
                  themeProvider.changeTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ),
            ProfileItem(
              text: AppLocalizations.of(context)!.language,
              item: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 25,
                  color: AppColors.mainLightColor,
                ),
              ),
            ),
            ProfileItem(
              text: AppLocalizations.of(context)!.logout,
              item: Icon(Icons.logout, size: 25, color: AppColors.redColor),
            ),
          ],
        ),
      ),
    );
  }
}
