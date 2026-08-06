import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileItem extends StatelessWidget {
  final String text;
  final Widget item;

  const ProfileItem({super.key, required this.text, required this.item});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var heidht = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: themeProvider.isDark()
            ? AppColors.darkInputBgColor
            : AppColors.whiteColor,
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      ),
      child: ListTile(
        title: Text(text, style: Theme.of(context).textTheme.titleSmall),
        trailing: item,
      ),
    );
  }
}
