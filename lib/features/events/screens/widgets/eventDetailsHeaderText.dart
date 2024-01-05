import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TEventDetailsHeaderText extends StatelessWidget {
  const TEventDetailsHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Year 2024",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Iconsax.calendar5,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              " 01 Jan 2024",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Row(
                          children: [
                            Icon(Iconsax.clock5,
                                color: Theme.of(context).primaryColor),
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
                        Icon(Iconsax.location5,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Auditorium, VIT Bhopal",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                );
  }
}