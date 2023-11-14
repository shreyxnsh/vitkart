import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/chips/choice_chips.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:t_store/common/widgets/text/product_price_text.dart';
import 'package:t_store/common/widgets/text/product_title_text.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TSectionHeading(
                        title: "Variation",
                        showActionButton: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: TSizes.md,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                            title: "Price : ",
                            smallSize: true,
                          ),
                          const SizedBox(
                            width: TSizes.xs,
                          ),

                          ///Actual Price
                          Text(
                            "\$25",
                            style:
                                Theme.of(context).textTheme.titleSmall!.apply(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                          const SizedBox(
                            width: TSizes.sm,
                          ),

                          /// Sale Price
                          const TProductPriceText(price: "20"),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: "Stock : ",
                            smallSize: true,
                          ),
                          const SizedBox(
                            width: TSizes.xs,
                          ),
                          Text(
                            "In Stack",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const TProductTitleText(
                title:
                    "This is the Discription of the Product and it can go up to maxnumum 4 lines",
                smallSize: true,
                maxLine: 4,
              ),
            ],
          ),
        ),

        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        // -- Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: "Colors"),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChips(
                  text: "Green",
                  selected: true,
                  onSelected: (p0) {},
                ),
                TChoiceChips(
                  text: "Blue",
                  selected: false,
                  onSelected: (p0) {},
                ),
                TChoiceChips(
                  text: "Yellow",
                  selected: false,
                  onSelected: (p0) {},
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: "Sizes"),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChips(
                  text: "EU 34",
                  selected: true,
                  onSelected: (p0) {},
                ),
                TChoiceChips(
                  text: "EU 36",
                  selected: false,
                  onSelected: (p0) {},
                ),
                TChoiceChips(
                  text: "Eu 38",
                  selected: false,
                  onSelected: (p0) {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
