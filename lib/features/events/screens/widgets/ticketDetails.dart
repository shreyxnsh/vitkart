import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketDetailsContainer extends StatelessWidget {
  const TicketDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color:
                            dark ? TColors.lightDarkBackground : TColors.primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Advitya Pro Show 2024",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Row(
                            children: [
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Text(
                                "Reg No.",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Shreyansh Jain",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                "21BSA10012",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Row(
                            children: [
                              Text(
                                "Time",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Text(
                                "Date",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "6:30PM - 00:00AM",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                " 22 Feb 2024",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Row(
                            children: [
                              Text(
                                "Location",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              Text(
                                "OD",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Football Ground, VIT Bhopal",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              Text(
                                "Yes",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems/2,
                          ),
                        ],
                      ),
                    );
  }
}