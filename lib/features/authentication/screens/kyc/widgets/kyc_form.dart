import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/navigation_menu.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class KYCform extends StatelessWidget {
  const KYCform({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.regNo,
                    prefixIcon: Icon(Iconsax.hashtag)),
              ),
              const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(Iconsax.sms)),
              ),
              const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.contact,
                    prefixIcon: Icon(Iconsax.call)),
              ),
              const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.joiningYear,
                    prefixIcon: Icon(Iconsax.calendar)),
              ),
              const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.source,
                    prefixIcon: Icon(Iconsax.hashtag)),
              ),
              const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(value: true, onChanged: (value){}, ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: TTexts.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark? TColors.white : TColors.primary,
                )),
                TextSpan(text: ' ${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: TTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark? TColors.white : TColors.primary,
                )),
              ]))
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        SizedBox(
    width: double.infinity,
    child: ElevatedButton(onPressed: (){
      Get.to(const NavigationMenu());
    }, child: const Text("Submit",)),
          )

      ],
    )
    );
  }
}
