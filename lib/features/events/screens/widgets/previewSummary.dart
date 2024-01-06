
import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PreviewOrderSummaryCard extends StatelessWidget {
  const PreviewOrderSummaryCard({Key? key}) : super(key: key);

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
                        "Order Summary",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(children: [
                    Text(
                      "Early Bird",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      "₹ 100",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ]),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(children: [
                    Text(
                      "Tax",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      "₹ 11.61",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ]),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                 
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: dark ? TColors.darkBackground : TColors.light,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Row(children: [
                    Text(
                      "Total",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      "₹ 121.61",
                      style: Theme.of(context).textTheme.titleMedium,
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
