import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/controllers/forgetPassword/forgetpass.dart';
import 'package:vitkart/features/authentication/screens/register/register.dart';
import 'package:vitkart/navigation_menu.dart';

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
    Get.to(const NavigationMenu());
  }

  void forgotPassword() {
    Get.to(const ForgetPasswordScreen());
  }

  void signUp() {
    Get.to(() => RegisterScreen());
  }
}
