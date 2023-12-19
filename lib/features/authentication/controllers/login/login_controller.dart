import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screens/kyc/kyc.dart';
import 'package:t_store/features/shop/screens/home/home.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isObscure = false.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    emailController.clear();
    passwordController.clear();
    isObscure.value = true;
    Get.to(const HomeScreen());
  }

  void forgotPassword() {}

  void signUp() {
    Get.to(const KYCScreen());
  }
}
