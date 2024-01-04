import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/registerHeading.dart';
import 'package:vitkart/features/authentication/screens/register/widget/subpages/page1.dart';
import 'package:vitkart/features/authentication/screens/register/widget/subpages/page2.dart';
import 'package:vitkart/features/authentication/screens/register/widget/subpages/page3.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    super.key,
    required this.dark,
    required this.controller,
    required this.defaultPinTheme,
  });

  final bool dark;
  final RegisterController controller;
  final PinTheme defaultPinTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TSizes.displayHeight(context) * 0.81,
      width: TSizes.displayWidth(context),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dark ? TColors.darkBackground : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // heading with page indicator
          RegisterHeading(
            controller: controller,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          // Sub Pages
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                Page1(controller: controller),
                Page2(controller: controller, dark: dark),
                Page3(controller: controller, defaultPinTheme: defaultPinTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
