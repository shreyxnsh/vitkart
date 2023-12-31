import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(
                title: 'You might like',
                showActionButton: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              // TGridLayout(
              //     itemCount: 4,
              //     itemBuilder: (_, index) => const TProductCardVertical()),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
