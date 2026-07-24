import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  VoidCallback onPressed;
  final String text;
  final bool selected;

  LanguageButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selected
            ? AppColors.mainLightColor
            : AppColors.whiteColor,
        foregroundColor: selected
            ? AppColors.whiteColor
            : AppColors.mainLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
