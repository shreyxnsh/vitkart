import 'package:flutter/material.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginPageForm.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

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
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/icons/vitkart/vitkart_logo_white.png",
                width: 170,
                height: 170,
              ),
              const SizedBox(
                height: 60,
              ),
               const LoginPageForm(),
            ],
          ),
        ),
      ),
    );
  }
}
