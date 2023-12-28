import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitkart/features/authentication/controllers/login/login_controller.dart';
import 'package:vitkart/features/authentication/screens/login/widget/DontHaveAccountButtonText.dart';
import 'package:vitkart/features/authentication/screens/login/widget/LoginPageSignInButton.dart';
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
  LoginPageForm({
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void loginUser() async {
    // check if user has added data
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
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
        Get.to(() => (NavigationMenu(token: myToken,)));
      } else {
        print("Something went wrong");
      }
      ;
    }
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
              onEditingComplete: () {},
              onTap: () {},
              obscureText: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            LoginScreenTextFeild(
              controller: _passwordController,
              labelText: TTexts.password,
              prefixIcon: Iconsax.key,
              keyboardType: TextInputType.visiblePassword,
              onEditingComplete: () {},
              onTap: () {},
              obscureText: !controller.isObscure.value,
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
                child: const Text(
                  TTexts.signIn,
                  style: TextStyle(
                    color: TColors.white,
                    fontSize: 16,
                  ),
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
