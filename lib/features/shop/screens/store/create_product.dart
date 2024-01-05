import 'dart:io';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/authentication/screens/register/widget/floatingButtonsBackAndNext.dart';
import 'package:vitkart/features/authentication/screens/register/widget/textFeildLikeButton.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/features/shop/screens/store/controller/create_product_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  CreateProductController get controller => Get.put(CreateProductController());

  Future<void> userChoice({
    required BuildContext context,
    required VoidCallback? isCamera,
    required VoidCallback? isGallery,
  }) async {
    final dark = THelperFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: dark ? TColors.darkBackground : TColors.light,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            splashColor: dark ? TColors.lightDarkBackground : TColors.primary,
            leading: Icon(
              Icons.camera,
              color: dark ? TColors.light : TColors.primary,
            ),
            title: Text(
              'Camera',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: dark ? TColors.light : TColors.primary,
                  ),
            ),
            onTap: isCamera,
          ),
          ListTile(
            splashColor: dark ? TColors.lightDarkBackground : TColors.primary,
            leading: Icon(
              Icons.photo,
              color: dark ? TColors.light : TColors.primary,
            ),
            title: Text(
              'Gallery',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: dark ? TColors.light : TColors.primary),
            ),
            onTap: isGallery,
          ),
        ],
      ),
    );
    return;
  }

  @override
  Widget build(BuildContext context) {
    const animatioDuration = Duration(milliseconds: 400);
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      floatingActionButton: Obx(
        () => FloatingBackNextButton(
          controller: controller,
          currentPageIndex: controller.selectedTab.value,
          endTextLabel: "Done",
          length: 3,
          onBack: () => controller.goPrevious(context),
          onNext: () => controller.goNext(context),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: TAppBar(
        title: Text(
          'Create Product',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
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
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: TColors.primary,
                          ),
                          borderRadius:
                              BorderRadius.circular(TSizes.cardRadiusLg),
                          color: dark
                              ? TColors.lightDarkBackground
                              : TColors.light,
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
                        tabs: [
                          SegmentTab(
                            label: "Product Details",
                            textColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
                            selectedTextColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
                            color: Colors.transparent,
                          ),
                          SegmentTab(
                            label: "Images",
                            textColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
                            selectedTextColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
                            color: Colors.transparent,
                          ),
                          SegmentTab(
                            label: "Preview",
                            textColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
                            selectedTextColor: dark
                                ? Colors.white
                                : TColors.lightDarkBackground,
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
                              height: TSizes.spaceBtwItems,
                            ),
                            Text(
                              TTexts.productName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            LoginScreenTextFeild(
                              prefixIcon: Iconsax.box,
                              keyboardType: TextInputType.name,
                              hintText: TTexts.productName,
                              controller: controller.productNameController,
                              // isBigTextField: ,
                              onChanged: (val) =>
                                  controller.updateDataList(0, val.isNotEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            Text(
                              TTexts.productPrice,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            LoginScreenTextFeild(
                              hintText: TTexts.productPrice,
                              controller: controller.productPriceController,
                              inputFormatters: [
                                // Filter to only allow price formate with decimal : "1234.56"
                                // FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]+\.?[0-9]{0,10}$')),
                              ],

                              // isBigTextField: true,
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee_rounded,
                              onChanged: (val) =>
                                  controller.updateDataList(1, val.isNotEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            Text(
                              TTexts.productQuantity,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            LoginScreenTextFeild(
                              hintText: TTexts.productQuantity,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: controller.productQuantityController,
                              // isBigTextField: true,
                              prefixIcon: Iconsax.computing,
                              keyboardType: TextInputType.number,
                              onChanged: (val) =>
                                  controller.updateDataList(2, val.isNotEmpty),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            Text(
                              "Product Category",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            // PullDownButton(
                            //   itemBuilder: (context) => [
                            //     PullDownMenuItem(
                            //       title: 'Category 1',
                            //       onTap: () {},
                            //     ),
                            //     PullDownMenuItem(
                            //       title: 'Category 2',
                            //       onTap: () {},
                            //     ),
                            //   ],
                            //   buttonBuilder: (context, showMenu) =>
                            //       TCirclularContainer(
                            //     onTap: showMenu,
                            //     radius: 10,
                            //     height: 40,
                            //     width: 200,
                            //     margen: const EdgeInsets.all(0),
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: TSizes.defaultSpace,
                            //     ),
                            //     backgroundColor: dark
                            //         ? TColors.lightDarkBackground
                            //         : TColors.light,
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           controller.selectedCategory?.value == null
                            //               ? "Select Category"
                            //               : controller.selectedCategory!.value
                            //                   .toString(),
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodySmall
                            //               ?.copyWith(
                            //                 color: dark
                            //                     ? TColors.light
                            //                     : TColors.dark,
                            //               ),
                            //         ),
                            //         const Spacer(),
                            //         Icon(
                            //           Iconsax.arrow_down_1,
                            //           color:
                            //               dark ? TColors.light : TColors.dark,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Obx(
                              () => TextFeildLikeButton(
                                onTap: () {
                                  controller.selectCategory(dark);
                                },
                                text: controller.selectedCategories.length == 1
                                    ? "1 Category Selected"
                                    : controller.selectedCategories.isNotEmpty
                                        ? "${controller.selectedCategories.length} Categories Selected"
                                        : "Select Category",
                                icon: Iconsax.category,
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
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
                                hintText: TTexts.productDescription,
                                controller:
                                    controller.productDescriptionController,
                                expands: false,
                                minLines: 5,
                                maxLines: 10,
                                maxLength: 1800,
                                isBigTextField: true,
                                onChanged: (val) => controller.updateDataList(
                                    3, val.isNotEmpty),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            Text(
                              "Product Cover Image ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),

                            /// product image
                            CreateProductImagePickerWidget(
                              file: controller.coverImage.value,
                              onStart: () async {
                                userChoice(
                                  context: context,
                                  isCamera: () async {
                                    controller.coverImage.value =
                                        await THelperFunctions
                                            .pickImageWithCrop(context, true);
                                    if (controller.coverImage.value != null) {
                                      controller.updateDataList(4, true);
                                    }
                                    Navigator.pop(context);
                                  },
                                  isGallery: () async {
                                    controller.coverImage.value =
                                        await THelperFunctions
                                            .pickImageWithCrop(context, false);
                                    if (controller.coverImage.value != null) {
                                      controller.updateDataList(4, true);
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              onRemove: () {
                                controller.updateDataList(4, false);
                                controller.coverImage.value = null;
                              },
                            ),

                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            Text(
                              "Additional Images ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: controller.progress.value > 0
                                    ? const NeverScrollableScrollPhysics()
                                    : const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: TSizes.spaceBtwItems,
                                  mainAxisSpacing: TSizes.spaceBtwItems,
                                  childAspectRatio: 1,
                                ),
                                itemCount:
                                    controller.additionalImages.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 4) {
                                    return const SizedBox.shrink();
                                  }
                                  if (index ==
                                      controller.additionalImages.length) {
                                    File? file;
                                    return EmptyImagePicker(
                                      onTap: () async {
                                        userChoice(
                                          context: context,
                                          isCamera: () async {
                                            file = await THelperFunctions
                                                .pickImageWithCrop(
                                                    context, true);
                                            if (file != null) {
                                              controller.additionalImages
                                                  .add(Rx(file));
                                            }
                                            Navigator.pop(context);
                                          },
                                          isGallery: () async {
                                            file = await THelperFunctions
                                                .pickImageWithCrop(
                                                    context, false);
                                            if (file != null) {
                                              controller.additionalImages
                                                  .add(Rx(file));
                                            }
                                            Navigator.pop(context);
                                          },
                                        );
                                        controller.progress.value += 0;
                                      },
                                    );
                                  }
                                  return CreateProductImagePickerWidget(
                                    file: controller
                                        .additionalImages[index].value,
                                    onStart: () async {
                                      userChoice(
                                        context: context,
                                        isCamera: () async {
                                          controller.additionalImages[index] =
                                              Rx(await THelperFunctions
                                                  .pickImageWithCrop(
                                                      context, true));

                                          Navigator.pop(context);
                                        },
                                        isGallery: () async {
                                          controller.additionalImages[index] =
                                              Rx(await THelperFunctions
                                                  .pickImageWithCrop(
                                                      context, false));

                                          Navigator.pop(context);
                                        },
                                      );
                                      controller.progress.value += 0;
                                    },
                                    onRemove: () {
                                      controller.additionalImages
                                          .removeAt(index);
                                      controller.progress.value += 0;
                                    },
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          children: [
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            controller.coverImage.value == null
                                ? const SizedBox.shrink()
                                : TRoundedImage(
                                    border: Border.all(color: TColors.light),
                                    imageUrl: controller.coverImage.value!.path,
                                    width: TSizes.displayWidth(context) * 0.72,
                                    height: TSizes.displayWidth(context) * 0.63,
                                    isFileImage: true,
                                    backgroundColor:
                                        TColors.lightDarkBackground,
                                    fit: BoxFit.cover,
                                  ),
                            Visibility(
                              visible: false,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    controller.additionalImages.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 12),
                                      child: TRoundedImage(
                                        border:
                                            Border.all(color: TColors.light),
                                        imageUrl: controller
                                            .additionalImages[index]
                                            .value!
                                            .path,
                                        width:
                                            TSizes.displayWidth(context) * 0.27,
                                        height:
                                            TSizes.displayWidth(context) * 0.27,
                                        isFileImage: true,
                                        backgroundColor:
                                            TColors.lightDarkBackground,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwSections,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.all(TSizes.defaultSpace),
                                  width: TSizes.displayWidth(context),
                                  // height: TSizes.displayHeight(context) * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TColors.grey,
                                    ),
                                    color: dark
                                        ? TColors.lightDarkBackground
                                        : TColors.light,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      PreviewDetailsTabWidget(
                                        leftHeading: TTexts.productName,
                                        leftSubHeading: controller
                                            .productNameController.text,
                                      ),
                                      const SizedBox(
                                        height: TSizes.spaceBtwInputFields,
                                      ),
                                      PreviewDetailsTabWidget(
                                        leftHeading: TTexts.productQuantity,
                                        leftSubHeading: controller
                                            .productQuantityController.text,
                                        rightHeading: TTexts.productPrice,
                                        rightSubHeading:
                                            "₹ ${controller.productPriceController.text}",
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.all(TSizes.defaultSpace),
                                  width: TSizes.displayWidth(context),
                                  // height: TSizes.displayHeight(context) * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TColors.grey,
                                    ),
                                    color: dark
                                        ? TColors.lightDarkBackground
                                        : TColors.light,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        TTexts.productDescription,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(
                                        height: TSizes.sm,
                                      ),
                                      Text(
                                        controller
                                            .productDescriptionController.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwSections * 3.6,
                            )
                          ],
                        ),
                      ),
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

class TextFeildLikeButton extends StatelessWidget {
  const TextFeildLikeButton({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.text,
    this.icon,
    this.onTap,
    this.radius,
    this.border,
    this.padding,
    this.margen,
    this.iconColor,
    this.iconSize,
  });

  final double? height;
  final double? width;
  final Color? backgroundColor;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onTap;
  final double? radius;
  final BoxBorder? border;
  final EdgeInsets? padding;
  final EdgeInsets? margen;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCirclularContainer(
      onTap: onTap,
      radius: radius ?? 10,
      height: height ?? 56,
      border: border ??
          Border.all(
            color: dark ? TColors.darkGrey : TColors.primary,
          ),
      width: width ?? TSizes.displayWidth(context),
      margen: margen ?? const EdgeInsets.all(0),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace,
          ),
      backgroundColor: backgroundColor ??
          (dark ? TColors.lightDarkBackground : TColors.light),
      child: Center(
        child: Row(
          children: [
            icon != null
                ? Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  )
                : const SizedBox(),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              text ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class PreviewDetailsTabWidget extends StatelessWidget {
  const PreviewDetailsTabWidget({
    super.key,
    this.leftHeading,
    this.leftSubHeading,
    this.rightHeading,
    this.rightSubHeading,
  });

  final String? leftHeading;
  final String? leftSubHeading;
  final String? rightHeading;
  final String? rightSubHeading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TProductTitleText(
              title: leftHeading ?? "",
              smallSize: true,
            ),
            const SizedBox(
              height: TSizes.xs,
            ),
            TProductTitleText(
              title: leftSubHeading ?? "",
              smallSize: false,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TProductTitleText(
              title: rightHeading ?? "",
              smallSize: true,
            ),
            const SizedBox(
              height: TSizes.xs,
            ),
            TProductTitleText(
              title: rightSubHeading ?? "",
              smallSize: false,
            ),
          ],
        ),
      ],
    );
  }
}

class CreateProductImagePickerWidget extends StatelessWidget {
  CreateProductImagePickerWidget({
    super.key,
    this.file,
    this.onStart,
    this.onRemove,
  });

  File? file;
  final VoidCallback? onStart;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      child: file != null
          ? Stack(
              children: [
                TRoundedImage(
                  fit: BoxFit.cover,
                  backgroundColor: TColors.lightDarkBackground,
                  isFileImage: true,
                  onPressed: onStart,
                  imageUrl: file!.path,
                  width: TSizes.displayWidth(context),
                  height: TSizes.displayHeight(context) * 0.36,
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      Iconsax.close_circle5,
                      shadows: const [
                        Shadow(
                          color: TColors.white,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: TColors.error,
                      size: TSizes.displayWidth(context) * (45 / 420),
                    ),
                  ),
                ),
              ],
            )
          : EmptyImagePicker(
              onTap: onStart,
            ),
    );
  }
}

class EmptyImagePicker extends StatelessWidget {
  const EmptyImagePicker({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      color: dark ? TColors.light : TColors.primary,
      strokeWidth: 2,
      dashPattern: const [16, 8],
      child: TCirclularContainer(
        onTap: onTap,
        width: TSizes.displayWidth(context),
        height: TSizes.displayHeight(context) * 0.36,
        radius: 8,
        backgroundColor:
            dark ? TColors.lightDarkBackground : TColors.grey.withOpacity(0.6),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.image,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              "Upload Cover Image",
            ),
          ],
        ),
      ),
    );
  }
}
