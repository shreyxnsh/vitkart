import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class LoginPageSignInButton extends StatelessWidget {
  final void Function()? onPressed;
  const LoginPageSignInButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        minimumSize: Size(TSizes.displayWidth(context) - 64, 54),
        maximumSize: Size(TSizes.displayWidth(context) - 64, 54),
      ),
      onPressed: onPressed,
      child: const Text(
        TTexts.signIn,
        style: TextStyle(
          color: TColors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
