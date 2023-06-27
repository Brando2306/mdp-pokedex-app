import 'package:flutter/material.dart';
import 'package:mdp_pokedex_app/src/presentation/common/constants/colors.dart';

class CustomInputs {
  static InputDecoration searchHomeInputDecoration({
    required String hintText,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? color,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Color? colorEnabledBorder,
    Color? colorFocusedBorder,
    TextStyle? hintStyle,
  }) {
    return InputDecoration(
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
      fillColor: color ?? AppColors.backgroundInput,
      filled: true,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: hintStyle ?? const TextStyle(color: AppColors.textPlaceholderInput),
      isDense: isDense,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: colorEnabledBorder ?? Colors.transparent,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: colorFocusedBorder ?? Colors.transparent,
          width: 1,
        ),
      ),
      // alignLabelWithHint: true,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 25,
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 25,
      ),
    );
  }
}
