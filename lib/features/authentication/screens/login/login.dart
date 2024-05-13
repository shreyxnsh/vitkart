import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginPageForm.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
      child: Scaffold(
        backgroundColor: TColors.primary,
        body: SingleChildScrollView(
          child: SizedBox(
            height: TSizes.displayHeight(context),
            width: TSizes.displayWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/images/banners/loginframe.png",
                        fit: BoxFit.fill,
                      ),
                      Lottie.asset(
                        "assets/lottie/login_screen_hi.json",
                        width: TSizes.displayWidth(context) * (140 / 420),
                        height: TSizes.displayHeight(context) * (140 / 840),
                      ),
                    ],
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LoginPageForm(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
