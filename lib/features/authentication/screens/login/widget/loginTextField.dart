import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class LoginScreenTextFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  const LoginScreenTextFeild({
    this.enabled,
    this.controller,
    super.key,
    this.labelText = "",
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: TColors.light,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
    );
  }
}
