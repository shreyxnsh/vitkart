import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class GenderButtons extends StatelessWidget {
  const GenderButtons({
    super.key,
    required this.controller,
    required this.dark,
  });

  final RegisterController controller;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (controller.gender.value == "Male") {
                  return;
                }
                controller.gender.value = "Male";
                log("male : ${controller.gender.value}");
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: controller.gender.value == "Male"
                      ? TColors.primary
                      : dark
                          ? TColors.lightDarkBackground
                          : TColors.light,
                  border: Border.all(
                    color: controller.gender.value == "Male"
                        ? TColors.primary
                        : dark
                            ? TColors.light
                            : TColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/categories/male.png",
                        width: 35,
                        height: 35,
                        color: controller.gender.value == "Male"
                            ? TColors.white // Set white color when selected
                            : TColors
                                .primary, // Set primary color when not selected
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(
                          color: controller.gender.value != "Male" && !dark
                              ? TColors.lightDarkBackground
                              : TColors.light,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
                if (controller.gender.value == "Female") {
                  return;
                }
                controller.gender.value = "Female";
                log("female : ${controller.gender.value}");
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: controller.gender.value == "Female"
                      ? TColors.primary
                      : dark
                          ? TColors.lightDarkBackground
                          : TColors.light,
                  border: Border.all(
                    color: controller.gender.value == "Female"
                        ? TColors.primary
                        : dark
                            ? TColors.light
                            : TColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/categories/female.png",
                        width: 35,
                        height: 35,
                        color: controller.gender.value == "Female"
                            ? TColors.white // Set white color when selected
                            : TColors
                                .primary, // Set primary color when not selected
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(
                          color: controller.gender.value != "Female" && !dark
                              ? TColors.lightDarkBackground
                              : TColors.light,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
