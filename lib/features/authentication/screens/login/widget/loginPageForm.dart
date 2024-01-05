import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vitkart/features/authentication/controllers/login/login_controller.dart';
import 'package:vitkart/features/authentication/screens/login/widget/DontHaveAccountButtonText.dart';
import 'package:vitkart/features/authentication/screens/login/widget/forgotPaswordButtonText.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginFormHeadings.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/navigation_menu.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/config/config.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  LoginController get controller => Get.put(LoginController());

  final userData = GetStorage();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void loginUser() async {
    // check if user has added data
    if (_emailController.text.isEmpty) {
      // Show CherryToast for empty email field
      CherryToast.error(
        title: const Text(""),
        displayTitle: false,
        description: const Text("User Email field empty",
            style: TextStyle(color: Colors.black)),
        animationType: AnimationType.fromRight,
        animationDuration: const Duration(milliseconds: 1000),
        autoDismiss: true,
      ).show(context);
      return;
    }

    if (_passwordController.text.isEmpty) {
      // Show CherryToast for empty password field
      CherryToast.error(
        title: const Text(""),
        displayTitle: false,
        description:
            const Text("Password field empty", style: TextStyle(color: Colors.black)),
        animationType: AnimationType.fromRight,
        animationDuration: const Duration(milliseconds: 1000),
        autoDismiss: true,
      ).show(context);
      return;
    }

    setState(() {
      isLoading = true;
    });

    // creating an object of registration body
    var regBody = {
      //json format
      "userEmail": _emailController.text,
      "userPassword": _passwordController.text
    };

    print(regBody);

    // http [post] request sent to api
    var response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(regBody));

    //getting the response by the server
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

    if (jsonResponse['status']) {
      var userGender = jsonResponse['authenticatedUser']['userGender'];
      var myToken = jsonResponse['authenticatedUser']['token'];

      print("User Gender: $userGender");
      print("User Token: $myToken");

      userData.write('token', myToken);

      // passing token data to dashboard screen
      Get.to(() => NavigationMenu(token: myToken));
    } else {
      // Show CherryToast for other errors
      CherryToast.error(
        title: const Text(""),
        displayTitle: false,
        description: const Text("Invalid account information",
            style: TextStyle(color: Colors.black)),
        animationType: AnimationType.fromRight,
        animationDuration: const Duration(milliseconds: 1000),
        autoDismiss: true,
      ).show(context);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () => Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: dark ? TColors.darkBackground : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginScreenHeadings(),
            LoginScreenTextFeild(
              controller: _emailController,
              labelText: TTexts.email,
              prefixIcon: Iconsax.user,
              keyboardType: TextInputType.emailAddress,
              // textInputAction: TextInputAction.next,
              onEditingComplete: () {},
              onTap: () {},
              obscureText: false,
              onFieldSubmitted: (value) {
                FocusScope.of(context).nextFocus();
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            LoginScreenTextFeild(
              controller: _passwordController,
              labelText: TTexts.password,
              prefixIcon: Iconsax.key,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {},
              onTap: () {},
              obscureText: !controller.isObscure.value,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              suffixIcon: GestureDetector(
                onTap: () {
                  controller.isObscure.value = !controller.isObscure.value;
                },
                child: Icon(
                  controller.isObscure.value ? Iconsax.eye : Iconsax.eye_slash,
                  size: 18,
                  color: !controller.isObscure.value
                      ? TColors.white
                      : TColors.primary,
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const ForgotPasswordTextButton(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  minimumSize: Size(TSizes.displayWidth(context) - 64, 54),
                  maximumSize: Size(TSizes.displayWidth(context) - 64, 54),
                ),
                onPressed: () async {
                  loginUser();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Show loading animation if isLoading is true
                    Visibility(
                      visible: isLoading,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    // Show button text when not loading
                    Visibility(
                      visible: !isLoading,
                      child: const Text(
                        TTexts.signIn,
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            DontHaveAccountButtonText(onPressed: controller.signUp),
          ],
        ),
      ),
    );
  }
}
