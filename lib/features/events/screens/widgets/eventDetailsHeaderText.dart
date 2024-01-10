import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TEventDetailsHeaderText extends StatelessWidget {
  const TEventDetailsHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Advitya Pro Show 2024",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(Iconsax.calendar5, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  " 22 Feb 2024",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Row(
              children: [
                Icon(Iconsax.clock5, color: Theme.of(context).primaryColor),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "06:30 PM - 00:00 AM",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Row(
          children: [
            Icon(Iconsax.location5, color: Theme.of(context).primaryColor),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Football Ground, VIT Bhopal",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Price & Sale Price

              /// Sale tag
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ticket Price : ",
                        style: Theme.of(context).textTheme.titleSmall!.apply(),
                      ),
                      const TProductPriceText(
                        price: "300",
                        isLarge: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      "Only 56 Tickets remaining",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ),
                  // const SizedBox(
                  //   width: TSizes.spaceBtwItems / 2,
                  // ),

                  // Price
                ],
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems / 1.5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
