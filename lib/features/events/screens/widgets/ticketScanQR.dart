import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketScanQRContainer extends StatelessWidget {
  const TicketScanQRContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: dark ? TColors.darkBackground : TColors.light,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(TSizes.defaultSpace),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  SizedBox(
                                    width: TSizes.displayHeight(context) * 0.2,
                                    child: Row(
                                      children: [
                                      Text(
                                        TTexts.scanqr,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      
                                    ]
                                    ),
                                  ),
                                  const SizedBox(
                                    height: TSizes.spaceBtwItems,
                                  ),
                                  SizedBox(
                                    width: TSizes.displayHeight(context) * 0.2,
                                    child: Row(
                                      
                                                              children: [
                                    Text(
                                      "Ticket ID",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "32212",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                                              ],
                                                            ),
                                  ),

                                ],
                              ),

                              Image.asset(
                                "assets/icons/events/dummyqr.png",
                                width: 100,
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
  }
}