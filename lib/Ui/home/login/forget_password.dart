import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * 0.02,
            top: height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).highlightColor,
            border: Border.all(width: 2, color: Theme.of(context).dividerColor),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.forgotPassword,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: height * 0.04,
          children: [
            Image.asset(AppAssets.reset_password, fit: BoxFit.fill),
            CustomElevatedButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).cardColor,
              verticalPadding: height * 0.01,
              child: Text(
                AppLocalizations.of(context)!.resetPassword,
                style: AppStyles.medium20white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
