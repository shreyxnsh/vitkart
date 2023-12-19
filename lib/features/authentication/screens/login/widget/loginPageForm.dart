import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/features/authentication/screens/login/widget/DontHaveAccountButtonText.dart';
import 'package:t_store/features/authentication/screens/login/widget/LoginPageSignInButton.dart';
import 'package:t_store/features/authentication/screens/login/widget/forgotPaswordButtonText.dart';
import 'package:t_store/features/authentication/screens/login/widget/loginFormHeadings.dart';
import 'package:t_store/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({
    super.key,
  });

  LoginController get controller => Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Ink(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginScreenHeadings(),
            LoginScreenTextFeild(
              controller: controller.emailController,
              labelText: TTexts.email,
              prefixIcon: Iconsax.user,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () {},
              onTap: () {},
              obscureText: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            LoginScreenTextFeild(
              controller: controller.passwordController,
              labelText: TTexts.password,
              prefixIcon: Iconsax.key,
              keyboardType: TextInputType.visiblePassword,
              onEditingComplete: () {},
              onTap: () {},
              obscureText: !controller.isObscure.value,
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.isObscure.value = !controller.isObscure.value;
                },
                child: Icon(
                  controller.isObscure.value ? Iconsax.eye : Iconsax.eye_slash,
                  size: 18,
                  color: !controller.isObscure.value
                      ? TColors.black
                      : TColors.warning,
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const ForgotPasswordTextButton(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            LoginPageSignInButton(
              onPressed: controller.login,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            DontHaveAccountButtonText(onPressed: controller.signUp),
          ],
        ),
      ),
    );
  }
}
