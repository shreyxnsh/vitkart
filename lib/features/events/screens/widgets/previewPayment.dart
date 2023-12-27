
import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PreviewPaymentCard extends StatelessWidget {
  const PreviewPaymentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
      
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: dark ? TColors.lightDarkBackground : TColors.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bottom Section with Event Details
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: dark ? TColors.lightDarkBackground : TColors.light,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(
                  color: dark ? TColors.lightDarkBackground : TColors.light,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Payment Method",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: dark ? TColors.darkBackground : TColors.light,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace/2),
                      child: Row(children: [
                    Image.asset(
                      "assets/icons/events/visa.png",
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      "Visa Platinum Card",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                        Text(
                          "5233 4212 7255 XXXX",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
