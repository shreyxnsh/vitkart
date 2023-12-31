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
  ];
  RxDouble progress = 0.0.obs;

  // Page 1 - About
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();

  // Page 2 - Images
  Rx<File?> image1 = Rx(null);
  Rx<File?> image2 = Rx(null);
  Rx<File?> image3 = Rx(null);
  Rx<File?> image4 = Rx(null);

  // Page 3 - Preview

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    focusNode.removeListener(() {
      isExpanded.value = false;
    });
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

  goNext() {
    if (selectedTab.value == 2) {
      Get.back();
      return;
    }
    selectedTab.value++;
    tabController.animateTo(
      selectedTab.value,
      duration: const Duration(milliseconds: 400),
    );
  }

  goPrevious() {
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
    dataList[index] = data;
    progressCheck();
  }

  Future<File?> imagePicker(BuildContext context) async {
    XFile? image = await THelperFunctions.pickImage(fromCamera: false);
    if (image == null) {
      showErrorToast(context, "Please select an image");
      return null;
    }
    File? croppedImage = await THelperFunctions.startImageCrop(image, context);
    if (croppedImage == null) return File(image.path);
    return croppedImage;
  }
}
