import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TEventDetailsHeaderText extends StatelessWidget {
  const TEventDetailsHeaderText({
    super.key,
    required this.ename,
    required this.edate,
    required this.estarttime,
    required this.eendtime,
    required this.evenue,
    required this.eprice,
    required this.eticketsLeft,
  });

  final String ename;
  final String edate;
  final String estarttime;
  final String eendtime;
  final String evenue;
  final String eprice;
  final int eticketsLeft;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ename,
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
                  DateFormat('dd MMM yyyy').format(DateTime.parse(edate)),
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
                  "${DateFormat('hh:mm a').format(DateTime.parse(estarttime))} - ${DateFormat('hh:mm a').format(DateTime.parse(eendtime))} ",
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
              evenue,
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
                      TProductPriceText(
                        price: eprice,
                        isLarge: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: eticketsLeft == 0
                        ? Colors.red.shade400
                        : TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      eticketsLeft == 0
                          ? "Sold Out"
                          : "Only $eticketsLeft Tickets remaining",
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: eticketsLeft == 0
                              ? TColors.white
                              : TColors.black),
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
