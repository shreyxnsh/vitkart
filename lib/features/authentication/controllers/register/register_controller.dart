import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController registerationNoController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  RxBool isPassObscure = false.obs;
  RxBool isCPassObscure = false.obs;

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    registerationNoController.dispose();
    yearController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
  }

  void register() {
    Get.to(const LoginScreen());
  }
}
