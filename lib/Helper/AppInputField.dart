import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:sizing/sizing.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.hint,
    required this.iconPath,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
  });

  final String hint;
  final String iconPath;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final bool obscureText;
  final Widget? suffixIcon;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool enabled;
  final int maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixIconConstraints:  BoxConstraints(minWidth: 44.ss, minHeight: 44.ss),
        prefixIcon: Padding(
          padding:  EdgeInsets.only(left: 12.ss, right: 8.ss),
          child: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
          borderSide: const BorderSide(color: ColorsConstant.colorBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
          borderSide: const BorderSide(color: ColorsConstant.colorSecondary, width: 1),
        ),
      ),
    );
  }
}
