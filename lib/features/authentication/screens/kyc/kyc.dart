import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/screens/kyc/widgets/kyc_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';

import '../../../../utils/helpers/helper_functions.dart';

class KYCScreen extends StatelessWidget {
  const KYCScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title:
            Text('KYC Verification', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: TSizes.xs / 2, bottom: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems, left: TSizes.spaceBtwItems),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
            
            Text(
              TTexts.kycSubTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections/1.5,
            ),

            KYCform(dark: dark)
          ]),
        ),
      ),
    );
  }
}

