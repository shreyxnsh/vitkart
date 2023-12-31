import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt selectedTab = 0.obs;
  RxInt selectedCategory = 0.obs;

  // top bar percentage

  // Page 1 - About
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();

  // Page 2 - Images
  String mainImage = "";
  String? subImage1;
  String? subImage2;
  String? subImage3;

  // Page 3 - Preview

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();

    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
  }

  goNext() {}
  goPrevious() {}

  progressCheck() {}
}
