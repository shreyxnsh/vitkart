import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: TSizes.spaceBtwItems),
          LoginScreenTextFeild(
            controller: controller.nameController,
            labelText: TTexts.name,
            prefixIcon: Iconsax.user,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          LoginScreenTextFeild(
            controller: controller.registerationNoController,
            labelText: TTexts.regNo,
            prefixIcon: Iconsax.personalcard,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          LoginScreenTextFeild(
            controller: controller.emailController,
            labelText: TTexts.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          LoginScreenTextFeild(
            controller: controller.passwordController,
            labelText: TTexts.password,
            prefixIcon: Iconsax.key,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !controller.isPassObscure.value,
            textInputAction: TextInputAction.next,
            suffixIcon: GestureDetector(
              onTap: () {
                controller.isPassObscure.value =
                    !controller.isPassObscure.value;
              },
              child: Icon(
                controller.isPassObscure.value
                    ? Iconsax.eye
                    : Iconsax.eye_slash,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          LoginScreenTextFeild(
            controller: controller.cpasswordController,
            labelText: TTexts.cpassword,
            prefixIcon: Iconsax.key,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !controller.isCPassObscure.value,
            textInputAction: TextInputAction.done,
            suffixIcon: GestureDetector(
              onTap: () {
                controller.isCPassObscure.value =
                    !controller.isCPassObscure.value;
              },
              child: Icon(
                controller.isCPassObscure.value
                    ? Iconsax.eye
                    : Iconsax.eye_slash,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
