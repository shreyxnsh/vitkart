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
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        SizedBox(
          height: TSizes.spaceBtwSections,
        
        ),
         Text(
          "👋 Good to see you back!",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         Text(
          TTexts.toContinue,
          
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
