import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class CreateProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt selectedTab = 0.obs;

  RxBool isLoading = false.obs;

  FocusNode focusNode = FocusNode();
  RxBool isExpanded = false.obs;

  // top bar percentage
  List<bool> dataList = <bool>[
    // about
    false,
    false,
    false,
    false,
    // images
    false,
    // preview
    false,
    // categories
    false,
  ];
  RxDouble progress = 0.0.obs;

  // Page 1 - About
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  List<String> categories = [
    'Electronics',
    'Clothing',
    'Books',
    'Home Decor',
    'Sports',
    'Beauty',
    'Food',
    'Toys',
    'Automotive',
    'Health',
    'Outdoor',
    'Pets',
    'Jewelry',
    'Music',
    'Movies',
    'Gaming',
    'Fitness',
    'Art',
    'Crafts',
    'Baby',
    'Furniture',
    'Tools',
    'Office Supplies',
    'Travel',
    'Shoes',
    'Accessories',
    'Party Supplies',
    'Grocery',
    'Appliances',
    'Stationery',
    'Garden',
    'Watches',
    'Hobbies',
    'Collectibles',
    'Kitchen',
    'Technology',
    'Gifts',
    'Halloween',
    'Christmas',
    'Valentine\'s Day',
    'Easter',
    'Sports Equipment',
    'Home Improvement',
    'Fashion',
    'Stationary',
    'School Supplies',
    'Electrical Appliances',
    'Bedding',
    'Cookware',
    'Musical Instruments',
    'Electronics Accessories',
    'Beauty Products',
    'Party Decorations',
    'Bathroom Accessories',
    'Outdoor Gear',
    'Board Games',
    'Pet Supplies',
    'Home Office',
    'Fitness Equipment',
    'Photography',
    'Craft Supplies',
    'Camping Gear',
    'Home Textiles',
    'Gardening Tools',
    'Fashion Accessories',
    'Fitness Apparel',
    'Art Supplies',
    'Baby Gear',
    'Furniture Accessories',
    'Power Tools',
    'Office Furniture',
    'Travel Accessories',
    'Sports Apparel',
    'Kitchen Appliances',
    'Collectible Figurines',
    'Video Games',
    'Music Instruments',
    'Smart Home Devices',
    'Gift Cards',
    'Party Costumes',
    'Outdoor Furniture',
    'Home Lighting',
    'Cooking Utensils',
    'Musical Accessories',
  ];
  RxList<String> selectedCategories = <String>[].obs;
  RxString? selectedCategory;
  TextEditingController productQuantityController = TextEditingController();

  // Page 2 - Images
  List<Rx<File?>> additionalImages = [];

  Rx<File?> coverImage = Rx(null);

  // Page 3 - Preview

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    getCategoriesList();
    tabController.addListener(() {
      if (tabController.index < selectedTab.value) {
        selectedTab.value = tabController.index;
      }
      if (selectedTab.value == 0) {
        page1Check(Get.context!)
            ? selectedTab.value = tabController.index
            : tabController.animateTo(0);
      }
      if (selectedTab.value == 1) {
        page2Check(Get.context!)
            ? selectedTab.value = tabController.index
            : tabController.animateTo(1);
      }
    });
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   tabController.dispose();

  //   productNameController.dispose();
  //   productDescriptionController.dispose();
  //   productPriceController.dispose();
  //   productQuantityController.dispose();
  // }

  getCategoriesList() {}

  goNext(BuildContext context) {
    if (selectedTab.value == 2) {
      Get.back();
      return;
    }
    if (selectedTab.value == 0 && !page1Check(context)) return;

    if (selectedTab.value == 1 && !page2Check(context)) {
      return;
    }

    selectedTab.value++;
    if (selectedTab.value == 2) {
      updateDataList(5, true);
    }
    tabController.animateTo(
      selectedTab.value,
      duration: const Duration(milliseconds: 400),
    );
  }

  bool page1Check(BuildContext context) {
    if (productNameController.text.isEmpty) {
      showErrorToast(context, "Please enter product name");
      return false;
    }
    if (productDescriptionController.text.isEmpty) {
      showErrorToast(context, "Please enter product description");
      return false;
    }
    if (productPriceController.text.isEmpty) {
      showErrorToast(context, "Please enter product price");
      return false;
    }
    if (productQuantityController.text.isEmpty) {
      showErrorToast(context, "Please enter product quantity");
      return false;
    }

    if (selectedCategories.isEmpty) {
      showErrorToast(context, "Please select categories");
      return false;
    }
    log("-----------------------------------page 1 check done-----------------------------------");
    log("product name: ${productNameController.text} --- datatype: ${productNameController.text.runtimeType}");
    log("product description: ${productDescriptionController.text} --- datatype: ${productDescriptionController.text.runtimeType}");
    log("product price: ${productPriceController.text} --- datatype: ${productPriceController.text.runtimeType}");
    log("product quantity: ${productQuantityController.text} --- datatype: ${productQuantityController.text.runtimeType}");
    log("selected categories: ${selectedCategories.length} --- datatype: ${selectedCategories.runtimeType}");
    log("-----------------------------------xxxxxxxxxxxxxxxx-----------------------------------");
    return true;
  }

  bool page2Check(BuildContext context) {
    if (coverImage.value == null) {
      showErrorToast(context, "Please select cover image");
      return false;
    }
    // if (additionalImages.isEmpty) {
    //   showErrorToast(context, "Please select additional images");
    //   return false;
    // }
    log("-----------------------------------page 2 check done-----------------------------------");
    log("cover image: ${coverImage.value!.path} --- datatype: ${coverImage.value.runtimeType}");
    log("additional images: ${additionalImages.length} --- datatype: ${additionalImages.runtimeType}");
    log("-----------------------------------xxxxxxxxxxxxxxxx-----------------------------------");
    return true;
  }

  goPrevious(BuildContext context) {
    if (selectedTab.value == 0) {
      Get.back();
      return;
    }

    selectedTab.value--;
    if (selectedTab.value == 1) {
      updateDataList(5, false);
    }
    tabController.animateTo(
      selectedTab.value,
      duration: const Duration(milliseconds: 400),
    );
  }

  progressCheck() {
    double val = 0;
    for (var i = 0; i < dataList.length; i++) {
      if (dataList[i]) {
        val += (100 / dataList.length);
      }
    }
    progress.value = val;
    log("progress: ${progress.value}");
  }

  updateDataList(int index, bool data) {
    if (index == dataList.length) {
      dataList.add(data);
      progressCheck();
      return;
    }
    dataList[index] = data;
    progressCheck();
  }

  selectCategory(bool dark) {
    Get.bottomSheet(
      Obx(
        () => Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SizedBox(
            height: Get.height * .5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text(
                    "Select Category",
                    style: Theme.of(Get.context!).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      for (var i = 0; i < categories.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (selectedCategories.contains(categories[i])) {
                              selectedCategories.remove(categories[i]);
                            } else {
                              selectedCategories.add(categories[i]);
                            }
                            if (selectedCategories.isEmpty) {
                              updateDataList(6, false);
                              return;
                            }
                            updateDataList(6, true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedCategories.contains(categories[i])
                                  ? TColors.primary
                                  : (dark ? TColors.dark : TColors.light),
                              border: Border.all(
                                color:
                                    selectedCategories.contains(categories[i])
                                        ? (dark
                                            ? TColors.light
                                            : TColors.lightDarkBackground)
                                        : TColors.darkerGrey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 36,
                            padding: const EdgeInsets.all(TSizes.sm),
                            child: Text(
                              categories[i],
                              style: Theme.of(Get.context!).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: dark ? TColors.dark : TColors.light,
      isScrollControlled: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(TSizes.cardRadiusLg),
        topRight: Radius.circular(TSizes.cardRadiusLg),
      )),
    );
  }
}
