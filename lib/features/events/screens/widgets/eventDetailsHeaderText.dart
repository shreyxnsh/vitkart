import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TEventDetailsHeaderText extends StatelessWidget {
  const TEventDetailsHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Garba Event",
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
                              "07 Jan 2024",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Icon(Iconsax.clock5,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "01:00 PM - 06:30 PM",
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