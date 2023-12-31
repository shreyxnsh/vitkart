import 'dart:developer';
import 'dart:io';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/authentication/screens/register/widget/floatingButtonsBackAndNext.dart';
import 'package:vitkart/features/shop/screens/store/controller/create_product_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class CreateProductScreen extends StatelessWidget {
  CreateProductScreen({super.key});

  CreateProductController get controller => Get.put(CreateProductController());

  @override
  Widget build(BuildContext context) {
    const animatioDuration = Duration(milliseconds: 400);

    return Scaffold(
      floatingActionButton: Obx(
        () => FloatingBackNextButton(
          controller: controller,
          currentPageIndex: controller.selectedTab.value,
          endTextLabel: "Done",
          length: 3,
          onBack: controller.goPrevious,
          onNext: controller.goNext,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: TAppBar(
        title: Text(
          'Create Product',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: TColors.lightDarkBackground,
                        ),
                      ),
                      Obx(
                        () => AnimatedContainer(
                          duration: animatioDuration,
                          width: (MediaQuery.of(context).size.width -
                                  (TSizes.defaultSpace * 2)) *
                              (controller.progress.value / 100),
                          height: 64,
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                          ),
                        ),
                      ),
                      SegmentedTabControl(
                        backgroundColor: Colors.transparent,
                        selectedTabTextColor: Colors.transparent,
                        controller: controller.tabController,
                        tabs: const [
                          SegmentTab(
                            label: "Product Details",
                            selectedTextColor: Colors.white,
                            color: Colors.transparent,
                          ),
                          SegmentTab(
                            label: "Images",
                            selectedTextColor: Colors.white,
                            color: Colors.transparent,
                          ),
                          SegmentTab(
                            label: "Preview",
                            selectedTextColor: Colors.white,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  viewportFraction: 1,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            LoginScreenTextFeild(
                              controller: controller.productNameController,
                              labelText: TTexts.productName,
                              prefixIcon: Iconsax.shop,
                              textInputAction: TextInputAction.next,
                              onChanged: (val) =>
                                  controller.updateDataList(0, !val.isEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            LoginScreenTextFeild(
                              controller: controller.productPriceController,
                              labelText: TTexts.productPrice,
                              prefixIcon: Icons.money_rounded,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (val) =>
                                  controller.updateDataList(1, !val.isEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            LoginScreenTextFeild(
                              controller: controller.productQuantityController,
                              labelText: TTexts.productQuantity,
                              prefixIcon: Iconsax.box,
                              keyboardType: TextInputType.number,
                              onChanged: (val) =>
                                  controller.updateDataList(2, !val.isEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            Text(
                              TTexts.productDescription,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            SizedBox(
                              height: 150,
                              child: LoginScreenTextFeild(
                                counterText: "",
                                controller:
                                    controller.productDescriptionController,
                                expands: false,
                                minLines: 5,
                                maxLines: 10,
                                maxLength: 1800,
                                isBigTextField: true,
                                onChanged: (val) =>
                                    controller.updateDataList(3, !val.isEmpty),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        Obx(
                          () => InkWell(
                            onTap: () async {
                              controller.image1.value =
                                  await controller.imagePicker(context);
                            },
                            borderRadius:
                                BorderRadius.circular(TSizes.cardRadiusLg),
                            splashFactory: NoSplash.splashFactory,
                            splashColor: TColors.primary,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius:
                                  const Radius.circular(TSizes.cardRadiusLg),
                              padding: const EdgeInsets.all(4),
                              color: TColors.primary,
                              child: AnimatedContainer(
                                width: TSizes.displayWidth(context) * 0.8,
                                height: TSizes.displayHeight(context) * 0.2,
                                decoration: BoxDecoration(
                                  color: TColors.lightDarkBackground,
                                  borderRadius: BorderRadius.circular(
                                      TSizes.cardRadiusLg),
                                ),
                                duration: animatioDuration,
                                child: controller.image1.value != null
                                    ? Image.file(
                                        controller.image1.value!,
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                              "Upload Main Image of the product"),
                                          const SizedBox(
                                            height: TSizes.spaceBtwItems,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                3,
                                              ),
                                              border: Border.all(
                                                color: TColors.primary,
                                              ),
                                            ),
                                            child: const Icon(
                                              Iconsax.image,
                                              color: TColors.primary,
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
                    const Column(
                      children: [
                        Text("Page 3"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
