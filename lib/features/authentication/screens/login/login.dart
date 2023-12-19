import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/screens/kyc/kyc.dart';
import 'package:t_store/features/authentication/screens/login/widget/loginPageForm.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              LoginPageForm(),
            ],
          ),
        ),
      ),
    );
  }
}
