
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PreviewEventCard extends StatelessWidget {
  const PreviewEventCard({Key? key}) : super(key: key);

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
            // Top Section with Background Image
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
             // Set the desired height for the background image
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                "assets/icons/events/previewimage.png",
              ),
            ),

            // Bottom Section with Event Details
            Container(
              padding: const EdgeInsets.only(left: 10 , right: 10),
              decoration: BoxDecoration(
                color: dark ? TColors.lightDarkBackground : TColors.light,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
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
                        "Advitya Pro Show 2024",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "VIT Bhopal",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.calendar5,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 3,
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
                          Icon(Iconsax.location5,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Parking Area",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(children: [
                    Text(
                      "Time",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      "OD",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ]),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    Text(
                      "06:30 PM - 00:00 AM",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      "Yes",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ]),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
