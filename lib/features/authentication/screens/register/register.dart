import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/register/register_controller.dart';
import 'package:t_store/features/authentication/screens/login/widget/LoginPageSignInButton.dart';
import 'package:t_store/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  RegisterController get controller => Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: TSizes.displayHeight(context),
          width: TSizes.displayWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                        width: TSizes.displayHeight(context) * 0.5,
                      ),
                      const Text(
                        "Student Details",
                        style: TextStyle(
                          color: TColors.dark,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        TTexts.toGetStarted,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: TColors.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      LoginScreenTextFeild(
                        controller: controller.nameController,
                        labelText: TTexts.name,
                        prefixIcon: Iconsax.user,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      LoginScreenTextFeild(
                        controller: controller.registerationNoController,
                        labelText: TTexts.regNo,
                        prefixIcon: Iconsax.personalcard,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      LoginScreenTextFeild(
                        controller: controller.emailController,
                        labelText: TTexts.email,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
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
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Iconsax.arrow_left_2,
                                color: TColors.white,
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.register();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: const Size.fromHeight(54),
                                  maximumSize: const Size.fromHeight(54),
                                ),
                                child: const Text("Register"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
