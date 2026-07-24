import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  VoidCallback onPressed;
  final IconData icon;
  final bool selected;

  ThemeButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: selected
          ? AppColors.mainLightColor
          : AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Icon(
        icon,
        color: selected ? AppColors.whiteColor : AppColors.mainLightColor,
      ),
    );
  }
}
