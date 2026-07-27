import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double? radius;
  final Color borderColor;
  final bool? filled;
  final Color? fillColor;
  final String? hintText;
  final String? lableText;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.radius,
    required this.borderColor,
    this.filled,
    this.fillColor,
    this.hintText,
    this.hintStyle,
    this.lableText,
    this.lableStyle,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: borderColor,
        ),
        focusedBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: borderColor,
        ),
        errorBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: AppColors.redColor,
        ),
        focusedErrorBorder: _builtDecorationBorder(
          radius: radius ?? 16,
          borderColor: AppColors.redColor,
        ),
        filled: filled,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: lableText,
        labelStyle: lableStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder _builtDecorationBorder({
    required double radius,
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
