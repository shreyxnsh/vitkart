import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vitkart/features/shop/screens/store/create_product.dart';
import 'package:vitkart/features/shop/screens/store/sell.dart';
import 'package:vitkart/navigation_menu.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class SellSuccessScreen extends StatefulWidget {
  const SellSuccessScreen({super.key});

  @override
  State<SellSuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SellSuccessScreen> {
  bool animateIt = false;
  bool fadeIt = false;
  final animationDuratino = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        animateIt = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        fadeIt = true;
      });
    });

    // pop from the screen after 3 seconds
    Future.delayed(const Duration(milliseconds: 4000), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: AnimatedOpacity(
      //   duration: animationDuratino,
      //   opacity: fadeIt ? 1.0 : 0.0,
      //   child: Container(
      //     margin: EdgeInsets.all(TSizes.spaceBtwItems),
      //     height: TSizes.displayHeight(context) * (54 / 840),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         Expanded(
      //           child: ElevatedButton(
      //             onPressed: () {
      //               Get.to(() => CreateProductScreen());
      //             },
      //             child: const Center(child: Text('Add More')),
      //           ),
      //         ),
      //         const SizedBox(
      //           width: TSizes.spaceBtwItems,
      //         ),
      //         Expanded(
      //           child: ElevatedButton(
      //             onPressed: () {
      //               Get.to(() => NavigationMenu());
      //             },
      //             child: const Center(child: Text('View Product')),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SizedBox(
        height: TSizes.displayHeight(context),
        width: TSizes.displayWidth(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/success_animation.json',
                  repeat: false,
                  width: TSizes.displayWidth(context) * 0.8,
                  fit: BoxFit.fitWidth,
                  // animate: animateIt,
                ),
                SizedBox(
                  width: TSizes.displayWidth(context) * 0.8,
                  child: AnimatedOpacity(
                    duration: animationDuratino,
                    opacity: fadeIt ? 1 : 0,
                    child: Center(
                      child: Text(
                        'Placed request successfully!',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize:
                                      TSizes.displayWidth(context) * (24 / 420),
                                  color: TColors.primary,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Lottie.asset(
              'assets/lottie/success_bg.json',
              repeat: false,
              fit: BoxFit.fitHeight,
              height: TSizes.displayHeight(context),
              animate: animateIt,
            ),
          ],
        ),
      ),
    );
  }
}
