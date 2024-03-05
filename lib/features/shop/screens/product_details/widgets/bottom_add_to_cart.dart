import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/products/products_cart/productsell.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TBootomAddToCart extends StatelessWidget {
  const TBootomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkBackground : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: 
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  SellSuccessScreen()
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.primary,
                side: const BorderSide(color: TColors.primary),
              ),
              child:  Text("Place Order" , style: Theme.of(context).textTheme.titleLarge,),
            ),
          ),
   
    );
  }
}
