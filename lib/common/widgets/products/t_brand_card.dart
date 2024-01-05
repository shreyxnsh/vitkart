import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/images/t_circular.image.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TBrandCard extends StatelessWidget {

  final Map<String, dynamic> snacksData;

  const TBrandCard({
    super.key,
    required this.dark, required this.snacksData, 
  });

  final bool dark;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                image: '${snacksData['icon']}',
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 3,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    '${snacksData['name']}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${snacksData['quantity']} Products',
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
