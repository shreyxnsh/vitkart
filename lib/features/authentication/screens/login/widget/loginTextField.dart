import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class LoginScreenTextFeild extends StatelessWidget {
  final double? height;
  final TextEditingController? controller;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isBigTextField;
  final int? maxLength;
  final bool? expands;
  final String? counterText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;

  const LoginScreenTextFeild({
    this.height,
    this.enabled,
    this.maxLines,
    this.onChanged,
    this.hintText,
    this.inputFormatters,
    this.isBigTextField,
    this.expands,
    this.minLines,
    this.controller,
    this.contentPadding,
    this.focusNode,
    this.maxLength,
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * (54 / 840),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        inputFormatters: inputFormatters,
        expands: expands ?? false,
        maxLength: maxLength,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          counterText: counterText,
          hintText: hintText,
          labelText: labelText,
          prefixIconColor: dark ? TColors.light : TColors.primary,
          prefixIcon: isBigTextField == true ? null : Icon(prefixIcon),
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
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
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
