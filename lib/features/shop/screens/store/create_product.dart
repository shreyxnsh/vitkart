import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/shop/screens/store/controller/create_product_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  CreateProductController get controller => Get.put(CreateProductController());

  @override
  Widget build(BuildContext context) {
    const animatioDuration = Duration(milliseconds: 400);

    return Scaffold(
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
                      AnimatedContainer(
                        duration: animatioDuration,
                        width: (MediaQuery.of(context).size.width -
                                (TSizes.defaultSpace * 2)) *
                            (18 / 100),
                        height: 64,
                        decoration: const BoxDecoration(
                          color: TColors.primary,
                        ),
                      ),
                      SegmentedTabControl(
                        backgroundColor: Colors.transparent,
                        selectedTabTextColor: Colors.transparent,
                        controller: controller.tabController,
                        tabs: [
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
                      child: Column(
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          LoginScreenTextFeild(
                            controller: controller.productNameController,
                            labelText: TTexts.productName,
                            prefixIcon: Iconsax.shop,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          LoginScreenTextFeild(
                            controller: controller.productDescriptionController,
                            labelText: TTexts.productDescription,
                            prefixIcon: Iconsax.note,
                            maxLines: 10,
                            minLines: 5,
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
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          LoginScreenTextFeild(
                            controller: controller.productQuantityController,
                            labelText: TTexts.productQuantity,
                            prefixIcon: Iconsax.box,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text("Page 2"),
                      ],
                    ),
                    Column(
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
