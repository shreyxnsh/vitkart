import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

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
         Text(TTexts.dontHaveAccount,
            style: Theme.of(context).textTheme.bodyLarge,),
        TextButton(
          onPressed: onPressed,
          child:  Text(
            TTexts.signUp,
            style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),
          ),
        ),
      ],
    );
  }
}
