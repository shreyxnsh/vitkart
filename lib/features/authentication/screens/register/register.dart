import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  RegisterController get controller => Get.put(RegisterController());

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
  //   borderRadius: BorderRadius.circular(8),
  // );

  // final submittedPinTheme = defaultPinTheme.copyWith(
  //   decoration: defaultPinTheme.decoration.copyWith(
  //     color: Color.fromRGBO(234, 239, 243, 1),
  //   ),
  // );
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: TColors.primary,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.back(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size.square(54),
                      maximumSize: const Size.square(54),
                    ),
                    child: const Center(
                      child: Icon(
                        Iconsax.arrow_left_2,
                        color: TColors.white,
                      ),
                    ),
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
                    child: Text(controller.currentPageIndex.value == 2
                        ? "Register"
                        : "Next"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: SizedBox(
          height: TSizes.displayHeight(context),
          width: TSizes.displayWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () => Container(
                  height: TSizes.displayHeight(context) * 0.89,
                  padding: const EdgeInsets.all(20),
                  decoration:  BoxDecoration(
                    color: dark ? TColors.darkBackground : TColors.light,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        "👨🏻‍🎓 Student Details",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
         Text(
          TTexts.toGetStarted,
          
          style: Theme.of(context).textTheme.headlineSmall,
        ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          for (int i = 0; i < 3; i++)
                            TCirclularContainer(
                              width: 20,
                              height: 4,
                              margen: const EdgeInsets.only(right: 10),
                              backgroundColor:
                                  i == controller.currentPageIndex.value
                                      ? TColors.primary
                                      : TColors.grey,
                            ),
                        ],
                        
                      ),
                      SizedBox(
                        height: TSizes.displayHeight(context) * 0.5,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                      controller:
                                          controller.registerationNoController,
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText:
                                          !controller.isPassObscure.value,
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
                                      controller:
                                          controller.cpasswordController,
                                      labelText: TTexts.cpassword,
                                      prefixIcon: Iconsax.key,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText:
                                          !controller.isCPassObscure.value,
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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: TSizes.spaceBtwSections,
                                      width:
                                          TSizes.displayHeight(context) * 0.5,
                                    ),
                                    LoginScreenTextFeild(
                                      controller: controller.phoneController,
                                      labelText: TTexts.phone,
                                      prefixIcon: Iconsax.mobile,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    LoginScreenTextFeild(
                                      controller:
                                          controller.joiningYearController,
                                      labelText: TTexts.yearOfJoining,
                                      prefixIcon: Iconsax.building_3,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    LoginScreenTextFeild(
                                      controller: controller.knowFromController,
                                      labelText:
                                          "Where did you get to know about VITKART?",
                                      prefixIcon: Iconsax.building_3,
                                      keyboardType: TextInputType.number,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: TColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        minimumSize: const Size.fromHeight(54),
                                        maximumSize: const Size.fromHeight(54),
                                      ),
                                      onPressed: () {
                                        controller.dobPicker(context);
                                      },
                                      child: const Text("Select DOB"),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Text(DateFormat.yMMMd()
                                        .format(controller.dob.value)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // UI of OTP screen
                                    const SizedBox(
                                      height: TSizes.spaceBtwSections,
                                    ),
                                    Center(
                                      child: Text(
                                        "OTP Verification",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .apply(
                                                fontSizeFactor: 1.2,
                                                fontWeightDelta: 1),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Text(
                                      "We just sent a 4-digit code to your phone number. Enter the code below.",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .apply(fontSizeFactor: 0.9),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwSections,
                                    ),
                                    Center(
                                      child: Pinput(
                                        controller: controller.otpController,
                                        defaultPinTheme: defaultPinTheme,
                                        submittedPinTheme:
                                            defaultPinTheme.copyWith(
                                          decoration: defaultPinTheme.decoration
                                              ?.copyWith(
                                            color: controller.isVerified.value
                                                ? const Color.fromRGBO(
                                                    206, 255, 210, 1)
                                                : const Color.fromRGBO(
                                                    234, 239, 243, 1),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        length: 4,
                                        onChanged: (s) {
                                          if (s == "2222") {
                                            controller.isVerified.value = true;
                                          } else {
                                            controller.isVerified.value = false;
                                          }
                                        },
                                        validator: (s) {
                                          return null;
                                        
                                          // if (s == "2222") {
                                          //   controller.isVerified.value = true;
                                          // } else {
                                          //   controller.isVerified.value = false;
                                          // }
                                          // return null;
                                        },
                                        pinputAutovalidateMode:
                                            PinputAutovalidateMode.onSubmit,
                                        showCursor: true,
                                        onCompleted: (pin) => print(pin),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Center(
                                        child: Text(
                                      "Didn't receive code?",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Resend",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .apply(
                                                  color:
                                                      controller.canResend.value
                                                          ? TColors.primary
                                                          : TColors.grey,
                                                  fontSizeFactor: 0.9),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
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
