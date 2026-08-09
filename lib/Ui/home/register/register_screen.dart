import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/my_user.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:evently_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/size_utils.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var rePasswordController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

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
                    AppLocalizations.of(context)!.createYourAccount,
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
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Please Enter name.";
                      }

                      return null;
                    },

                    fillColor: themeProvider.appTheme.isDark
                        ? AppColors.darkInputBgColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.lightgreyColor,
                    ),
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
                    obscureText: isPasswordHidden,
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
                    suffixIcon: IconButton(
                      color: AppColors.lightgreyColor, onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                      icon: Icon(isPasswordHidden ?
                      Icons.visibility_off_outlined : Icons
                          .visibility_outlined),
                    ),
                  ),
                  CustomTextField(
                    borderColor: Theme
                        .of(context)
                        .dividerColor,
                    filled: true,
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return "Please enter Password";
                      }
                      if (text != passwordController.text) {
                        return "Re-Password doesn't match Password";
                      }

                      return null;
                    },
                    fillColor: themeProvider.appTheme.isDark
                        ? AppColors.darkInputBgColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.confirmYourPassword,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.lightgreyColor,
                    ),
                    suffixIcon: IconButton(
                      color: AppColors.lightgreyColor, onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                      icon: Icon(isPasswordHidden ?
                      Icons.visibility_off_outlined : Icons
                          .visibility_outlined),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: register,
                    backgroundColor: Theme
                        .of(context)
                        .cardColor,
                    verticalPadding: height * 0.01,
                    child: Text(
                      AppLocalizations.of(context)!.signup,
                      style: AppStyles.medium20white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
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
                          AppLocalizations.of(context)!.signUpWithGoogle,
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, loadingText: "Waiting...");
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text, email: emailController.text);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.ubdateUser(myUser);
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context,
            message: "SignUp successfully",
            title: "Success",
            posActionName: "Ok",
            posAction: () {
              Navigator.pushReplacementNamed(context, AppRoutes.homescreen);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context,
              message: "The Password Provided too weak.",
              title: "Error", posActionName: "Ok");
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(context: context,
              message: "The account already exists for that email.",
              title: "Error", posActionName: "Ok");
          print('Wrong password provided for that user.');
        }
      }
      catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(context: context,
          message: e.toString(),
          title: "Error",
          posActionName: "Ok",);
      }
    }
  }
}
