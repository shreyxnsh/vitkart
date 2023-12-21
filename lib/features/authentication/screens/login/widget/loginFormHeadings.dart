import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class LoginScreenHeadings extends StatelessWidget {
  const LoginScreenHeadings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: TSizes.spaceBtwSections,
          width: TSizes.displayHeight(context) * 0.5,
        ),
        const Text(
          "Good to see you back!",
          style: TextStyle(
            color: TColors.dark,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const Text(
          TTexts.toContinue,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: TColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
