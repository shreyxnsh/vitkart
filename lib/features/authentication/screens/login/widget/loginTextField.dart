import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class LoginScreenTextFeild extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputAction? textInputAction;

  const LoginScreenTextFeild({
    this.height,
    this.enabled,
    this.controller,
    super.key,
    this.labelText = "",
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.07,
      child: TextField(
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIconColor: dark ? TColors.light : TColors.primary,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: TColors.white), // Set border color
          ),
          filled: true,
          fillColor: dark ? TColors.lightDarkBackground : TColors.light,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
