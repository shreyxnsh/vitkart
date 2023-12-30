import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class TechScreen extends StatelessWidget {
  const TechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Technology Products', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              DropdownButtonFormField(
          
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort), labelText: TTexts.filter), 
          onChanged: (value){

        },
        items: ['Lower Price', 'Higher Price', 'Sale', 'Newest', 'Most Popular']
        .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
              TGridLayout(
                    itemCount: 8,
                    itemBuilder: (_, index) => const TProductCardVertical(),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

