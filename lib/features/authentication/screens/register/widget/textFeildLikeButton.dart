import 'package:flutter/material.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class TextFieldLikeButton extends StatelessWidget {
  const TextFieldLikeButton({
    super.key,
    required this.controller,
    required this.dark,
    required this.labelText,
    this.prefixIcon,
    this.onTap,
  });

  final RegisterController controller;
  final bool dark;
  final String labelText;
  final Widget? prefixIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                dark ? TColors.lightDarkBackground : TColors.light,
              ),
              foregroundColor: dark
                  ? MaterialStateProperty.all(TColors.light)
                  : MaterialStateProperty.all(TColors.grey),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0,
                    color: dark ? TColors.grey : TColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              maximumSize: MaterialStateProperty.all(
                Size(200, 58),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(200, 58),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                prefixIcon ?? const SizedBox(),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  labelText == "" ? TTexts.DOB : labelText,
                  style: TextStyle(
                    color: dark ? TColors.light : TColors.darkBackground,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
