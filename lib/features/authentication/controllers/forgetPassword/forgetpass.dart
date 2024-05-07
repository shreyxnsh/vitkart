import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final PageController _pageController = PageController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Forget Password"),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            Page1(context),
            Page2(context),
          ],
        ),
      ),
    );
  }

  Widget Page1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter your email address to reset your password",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginScreenTextFeild(
            controller: _emailController,
            labelText: "Email",
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_emailController.text.trim().isEmpty) {
                showErrorToast(context, "Email cannot be empty");
                return;
              }
              if (GetUtils.isEmail(_emailController.text.trim()) == false ||
                  (_emailController.text.trim().split("@").last ==
                      "vitbhopal.ac.in") ||
                  _emailController.text.trim().contains("+")) {
                showErrorToast(context, "Invalid Email");
                return;
              }

              Map<String, dynamic> response =
                  await APIFunctions.resetPasswordSendMail(
                      email: _emailController.text.trim());
              log(response.toString());
              if (response["isSuccess"]) {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
                showSuccessToast(context, "Email sent successfully");
                return;
              }
              showErrorToast(context, response["message"]);
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  Widget Page2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter the OTP sent to your email (${_emailController.text}) address to reset your password",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginScreenTextFeild(
            controller: _newPasswordController,
            labelText: "New Password",
            prefixIcon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginScreenTextFeild(
            controller: _confirmPasswordController,
            labelText: "Confirm Password",
            prefixIcon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Pinput(
            controller: _otpController,
            defaultPinTheme: defaultPinTheme,
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration?.copyWith(
                color: _otpController.text.length == 4
                    ? const Color.fromRGBO(206, 255, 210, 1)
                    : const Color.fromRGBO(234, 239, 243, 1),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            length: 4,
            onChanged: (s) {},
            validator: (s) {
              return null;

              // if (s == "2222") {
              //   controller.isVerified.value = true;
              // } else {
              //   controller.isVerified.value = false;
              // }
              // return null;
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_newPasswordController.text.trim().isEmpty) {
                showErrorToast(context, "New Password cannot be empty");
                return;
              }

              if (_confirmPasswordController.text.trim().isEmpty) {
                showErrorToast(context, "Confirm Password cannot be empty");
                return;
              }

              if (_newPasswordController.text.trim() !=
                  _confirmPasswordController.text.trim()) {
                showErrorToast(context, "Passwords do not match");
                return;
              }

              if (_otpController.text.trim().isEmpty) {
                showErrorToast(context, "OTP cannot be empty");
                return;
              }

              Map<String, dynamic> response =
                  await APIFunctions.resetPasswordAPI(
                email: _emailController.text.trim(),
                newPassword: _newPasswordController.text.trim(),
                otp: _otpController.text.trim(),
              );
              if (response["isSuccess"]) {
                showSuccessToast(context, "Email sent successfully");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
                return;
              }
              showErrorToast(context, response["message"]);
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }
}
