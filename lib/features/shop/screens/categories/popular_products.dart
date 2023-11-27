import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class PopularProductScreen extends StatelessWidget {
  const PopularProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Popular Products', style: Theme.of(context).textTheme.headlineSmall),
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
                height: TSizes.spaceBtwSections,
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

