import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/floatingButtonsBackAndNext.dart';
import 'package:vitkart/features/authentication/screens/register/widget/registerForm.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterController get controller => Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    controller.currentPageIndex.value = 0;
  }

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
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: TColors.primary,
      floatingActionButton: FloatingBackNextButton(
        controller: controller,
        currentPageIndex: controller.currentPageIndex.value,
        endTextLabel: "Register",
        onNext: () {
          controller.registerPages(context);
        },
        onBack: () {
          controller.back(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text("Exit"),
                  content: const Text("Are you sure you want to exit"),
                  actions: [
                    CupertinoDialogAction(
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: TColors.primary),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        }),
                    CupertinoDialogAction(
                        child: const Text(
                          "No",
                          style: TextStyle(color: TColors.primary),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // heading
              SizedBox(
                height: TSizes.displayHeight(context) * (1 - 0.81),
              ),
              RegisterFormWidget(
                dark: dark,
                controller: controller,
                defaultPinTheme: defaultPinTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
