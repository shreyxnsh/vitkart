import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class ForgotPasswordTextButton extends StatelessWidget {
  final void Function()? onPressed;
  const ForgotPasswordTextButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      TextButton(
        onPressed: onPressed,
        child: const Text(TTexts.forgetPassword,
            style: TextStyle(
              color: TColors.primary,
              fontSize: 14,
            )),
      )
    ]);
  }
}
