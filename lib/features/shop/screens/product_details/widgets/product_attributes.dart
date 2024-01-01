import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/chips/choice_chips.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
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
        
      ],
    );
  }
}
