import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(
                title: 'You might like',
                showActionButton: true,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              // TGridLayout(
              //     itemCount: 4,
              //     itemBuilder: (_, index) => const TProductCardVertical()),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
