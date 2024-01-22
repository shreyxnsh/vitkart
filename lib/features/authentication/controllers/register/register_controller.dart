import 'dart:convert';
import 'dart:developer';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/navigation_menu.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/api_routes.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late List<SelectedListItem> joiningYearList;
  Rx<String> joiningYear = "".obs;
  Rx<String> gender = "unKnown".obs;
  TextEditingController knowFromController = TextEditingController();
  Rx<String> dob = "".obs;
  TextEditingController otpController = TextEditingController();
  RxBool isVerified = false.obs;
  RxBool canResend = true.obs;
  RxInt countdown = 30.obs;
  RxInt otpResendCount = 0.obs;
  PageController pageController = PageController();
  RxBool isPassObscure = false.obs;
  RxBool isCPassObscure = false.obs;
  RxInt currentPageIndex = 0.obs;
  RxBool isLoading = false.obs; // Added for loading state

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    registrationNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    phoneController.dispose();
    knowFromController.dispose();
    pageController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getJoiningYearList();
  }

  getJoiningYearList() {
    joiningYearList = [];

    for (var i = DateTime.now().year - 4; i <= DateTime.now().year; i++) {
      joiningYearList.add(
        SelectedListItem(
          name: "$i",
          value: "$i",
          isSelected: false,
        ),
      );
    }
  }

  selectBatch(BuildContext context) {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          "Select Your Batch  👇",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        data: joiningYearList,
        enableMultipleSelection: false,
        selectedItems: (selectedItems) {
          joiningYear.value = selectedItems.first.name;
        },
        searchWidget: null,
      ),
    ).showModal(context);
  }

  resendOTP() {
    otpResendCount.value++;
    countdown.value = 60 * otpResendCount.value;
  }

  Future<void> registerUser() async {
    isLoading.value = true; // Start loading animation

    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Map<String, String> regBody = {
          "userEmail": emailController.text,
          "userPassword": passwordController.text,
          "userRegID": registrationNoController.text,
          "userName": nameController.text,
          "userGender": gender.value,
          "userBatch": joiningYear.value,
          "userBirthDate": dob.value,
          "userContactNum": phoneController.text,
        };

        print(regBody);
        Map<String, dynamic> reponse =
            await APIFunctions.createUser(data: regBody);
        if (reponse['isSuccess']) {
          showErrorToast(
            Get.context!,
            reponse['message'],
            animationCurve: Curves.fastLinearToSlowEaseIn,
          );
          return;
        }
        showErrorToast(
          Get.context!,
          reponse['errors'] ?? "Something went wrong",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred");
    } finally {
      isLoading.value = false; // Stop loading animation
    }
  }

  Future<bool> OTPVerification(BuildContext context) async {
    isLoading.value = true; // Start loading animation

    try {
      if (emailController.text.isNotEmpty && otpController.text.isNotEmpty) {
        Map<String, dynamic> jsonResponse = await APIFunctions.otpVerify(
          email: emailController.text.trim(),
          otp: otpController.text.trim(),
        );
        log(jsonResponse.toString());
        if (jsonResponse['status'] == false) {
          // OTP is valid and user is verified
          log("${jsonResponse['message']}");
          showErrorToast(
            context,
            jsonResponse['message'],
            animationCurve: Curves.fastLinearToSlowEaseIn,
          ); // Navigate to NavigationMenu
          isLoading.value = false;
          return false;
        }

        if (jsonResponse['isVerified']) {
          log("${jsonResponse['message']}");
          showSuccessToast(
            context,
            "Verification Successful, Kindly login",
            animationCurve: Curves.fastLinearToSlowEaseIn,
          ); // Nav
          Get.to((() => const LoginScreen()));
          isLoading.value = false;
          return true;

          // Show error toast for invalid OTP
        }
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred");
      return false;
    } finally {
      isLoading.value = false;

      // Stop loading animation
    }
    return false;
  }

  Future<void> registerPages(BuildContext context) async {
    if (0 == currentPageIndex.value) {
      if (nameController.text.isEmpty) {
        showErrorToast(
          context,
          "You have not entered your name",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (registrationNoController.text.isEmpty) {
        showErrorToast(
          context,
          "You have not entered your registratioon number",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (emailController.text.isEmpty) {
        showErrorToast(
          context,
          "You have not entered your email",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (!GetUtils.isEmail(emailController.text)) {
        showErrorToast(
          context,
          "Email is not valid",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (emailController.text.split("@").last != "vitbhopal.ac.in") {
        showErrorToast(
          context,
          "Email should be of vitbhopal.ac.in domain only",
        );
        return;
      }
      if (passwordController.text.isEmpty) {
        showErrorToast(
          context,
          "Password can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (cpasswordController.text.isEmpty) {
        showErrorToast(
          context,
          "Confirm Password can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (passwordController.text != cpasswordController.text) {
        showErrorToast(
          context,
          "Password and Confirm Password should be the same",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      log("Name - ${nameController.text}");
      log("Registration No - ${registrationNoController.text}");
      log("Email - ${emailController.text}");
      log("Password - ${passwordController.text}");
      log("CPassword - ${cpasswordController.text}");
      log("Phone - ${phoneController.text}");
    }

    if (1 == currentPageIndex.value) {
      if (phoneController.text.isEmpty) {
        showErrorToast(
          context,
          "Phone can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if (!GetUtils.isPhoneNumber(phoneController.text)) {
        showErrorToast(
          context,
          "Phone is not valid",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if (gender.value.isEmpty) {
        showErrorToast(
          context,
          "Gender can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if (dob.value == "") {
        showErrorToast(
          context,
          "Dob can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if ((DateTime.now().year - int.parse(dob.value.split('-').last) < 17)) {
        showErrorToast(
          context,
          "Age shouldn't be less than 17",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if (joiningYear.value.isEmpty) {
        showErrorToast(
          context,
          "Joining Year can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      log("Name - ${nameController.text}");
      log("Registration No - ${registrationNoController.text}");
      log("Email - ${emailController.text}");
      log("Password - ${passwordController.text}");
      log("CPassword - ${cpasswordController.text}");
      log("Phone - ${phoneController.text}");
      log("Gender - $gender");
      log("Joining Year - ${joiningYear.value}");
      log("Know From - ${knowFromController.text}");
      log("Dob - ${dob.value.toString()}");

      await registerUser();

      otpResendCount.value++;
      countdown.value = 30 * otpResendCount.value;
    }

    if (2 == currentPageIndex.value) {
      if (otpController.text.isEmpty) {
        showErrorToast(
          context,
          "OTP can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      log("Otp - ${otpController.text}");
      log("Email  - ${emailController.text}");
      // Call OTPVerification function
      bool val = await OTPVerification(context);

      log("Can Resend - ${canResend.value}");
      log("Page Index - ${currentPageIndex.value}");

      return;
    }

    pageController.animateToPage(
      currentPageIndex.value + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    currentPageIndex.value = currentPageIndex.value + 1;
  }

  void back(BuildContext context) {
    if (currentPageIndex.value == 0) {
      Navigator.pop(context);
      return;
    }
    pageController.animateToPage(
      currentPageIndex.value - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    currentPageIndex.value = currentPageIndex.value - 1;
  }

  void updatePageIndex(index) {
    currentPageIndex.value = index;
  }

  void dobPicker(BuildContext context, Color bgColor, String format) async {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: bgColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Your Date of Birth 📅",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: dob.value == ""
                    ? DateTime(2000, 1, 1)
                    : DateFormat(format).parse(dob.value),
                onDateTimeChanged: (DateTime dateTime) {
                  dob.value = DateFormat(format).format(dateTime);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
