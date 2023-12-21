import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class DontHaveAccountButtonText extends StatelessWidget {
  final void Function()? onPressed;
  const DontHaveAccountButtonText({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(TTexts.dontHaveAccount,
            style: TextStyle(
              color: TColors.dark,
              fontSize: 14,
            )),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            TTexts.signUp,
            style: TextStyle(
              color: TColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
