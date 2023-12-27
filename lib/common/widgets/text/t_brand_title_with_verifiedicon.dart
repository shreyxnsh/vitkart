import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/text/t_brand_title.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/enums.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
     this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
     this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitle(
              color: textColor,
              title: title,
              maxLines: maxLines,
              textAlign: textAlign,
              brandTextSize: brandTextSizes
              ),
          ),
          const SizedBox(
            width: TSizes.xs,
          ),
          Icon(Iconsax.verify5, color: iconColor, size: TSizes.iconXs,)
      ],
    );
  }
}
