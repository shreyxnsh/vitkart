import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/floatingButtonsBackAndNext.dart';
import 'package:vitkart/features/authentication/screens/register/widget/registerForm.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

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
          showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text(""),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Yes"),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ));
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
