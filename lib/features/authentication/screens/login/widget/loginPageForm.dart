

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
import 'package:t_store/utils/helpers/helper_functions.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({
    super.key,
  });

  LoginController get controller => Get.put(LoginController());

  
  
  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);


    return Obx(
      () => Ink(
        padding: const EdgeInsets.all(20),
        
        decoration:  BoxDecoration(
          
          color: dark ? TColors.darkBackground : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      ? TColors.white
                      : TColors.primary,
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const ForgotPasswordTextButton(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: LoginPageSignInButton(
                onPressed: controller.login,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            DontHaveAccountButtonText(onPressed: controller.signUp),
          ],
        ),
      ),
    );
  }
}
