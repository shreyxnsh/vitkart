import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/authentication/screens/register/widget/genderButtons.dart';
import 'package:vitkart/features/authentication/screens/register/widget/textFeildLikeButton.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
    required this.controller,
    required this.dark,
  });

  final RegisterController controller;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: TSizes.spaceBtwItems),
          LoginScreenTextFeild(
            controller: controller.phoneController,
            labelText: TTexts.phone,
            prefixIcon: Iconsax.mobile,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          GenderButtons(controller: controller, dark: dark),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // formate of date - DD--MM-YYYY
          Obx(
            () => TextFieldLikeButton(
              controller: controller,
              dark: dark,
              labelText: controller.Dob.value,
              onTap: () => controller.dobPicker(
                context,
                dark ? TColors.darkBackground : TColors.light,
                "dd-MM-yyyy",
              ),
              prefixIcon: Icon(
                Iconsax.calendar,
                color: dark ? TColors.light : TColors.primary,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFieldLikeButton(
              controller: controller,
              onTap: () {
                controller.selectBatch(context);
              },
              dark: dark,
              labelText: controller.joiningYear.value == ""
                  ? "Select Batch Year"
                  : controller.joiningYear.value,
              prefixIcon: Icon(
                Iconsax.building,
                color: dark ? TColors.light : TColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
