import 'dart:developer';

import 'package:dropdown_model_list/drop_down/select_drop_list.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
                      controller.register(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size.fromHeight(54),
                      maximumSize: const Size.fromHeight(54),
                    ),
                    child: Obx(
                      () => Text(controller.currentPageIndex.value == 2
                          ? "Register"
                          : "Next"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // heading
            SizedBox(
              height: TSizes.displayHeight(context) * (1 - 0.81),
            ),
            Obx(
              () => Container(
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
                    // heading
                    Text(
                      "👨🏻‍🎓 Student Details",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
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
                                controller.currentPageIndex.value == i
                                    ? TColors.primary
                                    : TColors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                  controller:
                                      controller.registerationNoController,
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
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.gender.value ==
                                              "Male") {
                                            return;
                                          }
                                          controller.gender.value = "Male";
                                          log("male : ${controller.gender.value}");
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          decoration: BoxDecoration(
                                            color: controller.gender.value ==
                                                    "Male"
                                                ? TColors.primary
                                                : dark
                                                    ? TColors
                                                        .lightDarkBackground
                                                    : TColors.light,
                                            border: Border.all(
                                              color: controller.gender.value ==
                                                      "Male"
                                                  ? TColors.primary
                                                  : dark
                                                      ? TColors.light
                                                      : TColors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Male",
                                              style: TextStyle(
                                                color:
                                                    controller.gender.value !=
                                                                "Male" &&
                                                            !dark
                                                        ? TColors
                                                            .lightDarkBackground
                                                        : TColors.light,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: TSizes.spaceBtwInputFields,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.gender.value ==
                                              "Female") {
                                            return;
                                          }
                                          controller.gender.value = "Female";
                                          log("male : ${controller.gender.value}");
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          decoration: BoxDecoration(
                                            color: controller.gender.value ==
                                                    "Female"
                                                ? TColors.primary
                                                : dark
                                                    ? TColors
                                                        .lightDarkBackground
                                                    : TColors.light,
                                            border: Border.all(
                                              color: controller.gender.value ==
                                                      "Female"
                                                  ? TColors.primary
                                                  : dark
                                                      ? TColors.light
                                                      : TColors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Female ",
                                              style: TextStyle(
                                                color:
                                                    controller.gender.value !=
                                                                "Female" &&
                                                            !dark
                                                        ? TColors
                                                            .lightDarkBackground
                                                        : TColors.light,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                SelectDropList(
                                  itemSelected: controller
                                      .joiningYearList.listOptionItems.first,
                                  dropListModel: controller.joiningYearList,
                                  showIcon: true, // Show Icon in DropDown Title
                                  showArrowIcon:
                                      true, // Show Arrow Icon in DropDown
                                  showBorder: true,
                                  paddingTop: 0,
                                  icon: const Icon(Icons.person,
                                      color: Colors.black),
                                  onOptionSelected: (optionItem) {
                                    // optionItemSelected = optionItem;
                                    // setState(() {});
                                  },
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
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.dobPicker(
                                            context,
                                            dark
                                                ? TColors.darkBackground
                                                : TColors.light,
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            dark
                                                ? TColors.lightDarkBackground
                                                : TColors.light,
                                          ),
                                          foregroundColor: dark
                                              ? MaterialStateProperty.all(
                                                  TColors.light)
                                              : MaterialStateProperty.all(
                                                  TColors.grey),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 2,
                                                color: dark
                                                    ? TColors.light
                                                    : TColors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                          ),
                                          maximumSize:
                                              MaterialStateProperty.all(
                                            Size(200, 58),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                            Size(200, 58),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Iconsax.calendar,
                                              color: dark
                                                  ? TColors.light
                                                  : TColors.primary,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              controller.Dob.value == ""
                                                  ? TTexts.DOB
                                                  : controller.Dob.value,
                                              style: TextStyle(
                                                color: dark
                                                    ? TColors.light
                                                    : TColors.darkBackground,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: TSizes.spaceBtwItems),
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
                                    submittedPinTheme: defaultPinTheme.copyWith(
                                      decoration:
                                          defaultPinTheme.decoration?.copyWith(
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
                                  style: Theme.of(context).textTheme.bodySmall,
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
                                              color: controller.canResend.value
                                                  ? TColors.primary
                                                  : TColors.grey,
                                              fontSizeFactor: 0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
    );
  }
}
