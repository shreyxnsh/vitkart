import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/enums.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Price & Sale Price
          Row(
            children: [
              /// Sale tag
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      "25%",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.black),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
    
                  // Price
                  Text(
                    "\$250",
                    style: Theme.of(context).textTheme.titleSmall!.apply(
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  const TProductPriceText(
                    price: "175",
                    
                    isLarge: true,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: TSizes.iconMd,
            ),
          ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 1.5,
          ),
    
          /// Titile
          const TProductTitleText(title: "Green Nike Shoes Shirt" , smallSize: false,),
          const SizedBox(
            height: TSizes.spaceBtwItems / 1.5,
          ),
    
          /// Stock Status
          Row(
            children: [
              const TProductTitleText(title: "Quantity :" , smallSize : true),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                "2",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 1.5,
          ),
    
          
        ],
      ),
    );
  }
}

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLine = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLine;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLine: maxLine,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: TSizes.iconXs,
        ),
      ],
    );
  }
}

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({
    super.key,
    this.color,
    required this.title,
    this.maxLine = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLine;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.small
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextSize == TextSizes.small
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
