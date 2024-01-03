import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

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
    false,
    false,
    false,
    false,
  ];
  RxDouble progress = 0.0.obs;

  // Page 1 - About
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
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

  goNext(BuildContext context) {
    if (selectedTab.value == 2) {
      Get.back();
      return;
    }
    if (selectedTab.value == 0 && !page1Check(context)) return;

    if (selectedTab.value == 1 && !page2Check(context)) return;
    selectedTab.value++;
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
    return true;
  }

  bool page2Check(BuildContext context) {
    return true;
  }

  goPrevious(BuildContext context) {
    if (selectedTab.value == 0) {
      Get.back();
      return;
    }

    selectedTab.value--;
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
}
