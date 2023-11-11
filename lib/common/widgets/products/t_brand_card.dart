
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:t_store/common/widgets/images/t_circular.image.dart';
import 'package:t_store/common/widgets/text/t_brand_title_with_verifiedicon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){},
    child: TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.sm),
      showBorder: true,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Flexible(

            child: TCircularImage(
              dark: dark,
              isNetworkImage: false,
              backgroundColor: Colors.transparent,
              overlayColor: dark ? TColors.white : TColors.black, 
              image: TImages.clothIcon,
              ),
          ),
            const SizedBox(
              width: TSizes.spaceBtwItems/2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                        title: 'Nike',
                        brandTextSizes: TextSizes.large,
                      ),
                      Text(
                        '256 Products',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                ],
              ),
            )
        ],
      ),
    
    ),
    );
  }
}

