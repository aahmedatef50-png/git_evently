import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/size_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * 0.02,
                children: [
                  Image.asset(
                    themeProvider.appTheme.isDark
                        ? AppAssets.onboarding_dark
                        : AppAssets.onboarding_light,
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginToYourAccount,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                  CustomTextField(
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    filled: true,
                    controller: emailController,
                    kyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Please Enter Email.";
                      }
                      final bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text);
                      if (!emailValid) {
                        return "Please enter a valid Email.";
                      }
                      return null;
                    },
                    fillColor: themeProvider.appTheme.isDark
                        ? AppColors.darkInputBgColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.enterYourEmail,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.lightgreyColor,
                    ),
                  ),
                  CustomTextField(
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    filled: true,
                    controller: passwordController,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Please enter Password";
                      }
                      if (text.length < 6) {
                        return "Please should be at least 6 chars";
                      }
                      return null;
                    },
                    fillColor: themeProvider.appTheme.isDark
                        ? AppColors.darkInputBgColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.lightgreyColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.lightgreyColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '${AppLocalizations.of(context)!.forgotPassword} ?',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            decorationColor: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: login,
                    backgroundColor: Theme
                        .of(context)
                        .cardColor,
                    verticalPadding: height * 0.01,
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.medium20white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAnAccount,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.register_screen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            decorationColor: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme
                              .of(context)
                              .dividerColor,
                          indent: width * 0.01,
                          endIndent: width * 0.04,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme
                              .of(context)
                              .dividerColor,
                          indent: width * 0.04,
                          endIndent: width * 0.01,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: themeProvider.appTheme.isDark
                        ? AppColors.darkInputBgColor
                        : AppColors.whiteColor,
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    verticalPadding: height * 0.02,
                    child: Row(
                      spacing: width * 0.04,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.google_icon),
                        Text(
                          AppLocalizations.of(context)!.loginWithGoogle,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {

    }
  }
}
