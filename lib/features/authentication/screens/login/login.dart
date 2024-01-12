import 'package:flutter/material.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginPageForm.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: TSizes.displayHeight(context),
          width: TSizes.displayWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/icons/vitkart/vitkart_logo_white.png",
                width: TSizes.displayWidth(context) * (170 / 420),
                height: TSizes.displayHeight(context) * (170 / 840),
              ),

              // Lottie.asset(
              //   "assets/lottie/login_screen_hi.json",
              //   width: TSizes.displayWidth(context) * (170 / 420),
              //   height: TSizes.displayHeight(context) * (170 / 840),
              // ),
              SizedBox(
                height: TSizes.displayHeight(context) * (72 / 840),
              ),
              const LoginPageForm(),
            ],
          ),
        ),
      ),
    );
  }
}
