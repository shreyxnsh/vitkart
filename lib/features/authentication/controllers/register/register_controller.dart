import 'dart:convert';
import 'dart:developer';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/utils/config/config.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class RegisterController extends GetxController {
  // page one
  TextEditingController nameController = TextEditingController();
  TextEditingController registerationNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  //page two
  TextEditingController phoneController = TextEditingController();
  late List<SelectedListItem> joiningYearList;
  Rx<String> joiningYear = "".obs;
  Rx<String> gender = "unKnown".obs;
  TextEditingController knowFromController = TextEditingController();
  Rx<String> Dob = "".obs;

  // Page three
  TextEditingController otpController = TextEditingController();
  RxBool isVerified = false.obs;
  RxBool canResend = true.obs;
  RxInt countdown = 30.obs;
  RxInt otpResendCount = 0.obs;
  PageController pageController = PageController();

  RxBool isPassObscure = false.obs;
  RxBool isCPassObscure = false.obs;
  RxInt currentPageIndex = 0.obs;

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    registerationNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    phoneController.dispose();
    knowFromController.dispose();
    pageController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getJoiningYearList();
    // currentPageIndex.value = 0;
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

  void registerUser() async {
    // check if user has added data
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // creating an object of registration body
      var regBody = {
        //json format
        "userEmail": emailController.text,
        "userPassword": passwordController.text,
        "userRegID": registerationNoController.text,
        "userName": nameController.text,
      };

      print(regBody);

      // http [post] request sent to api
      var response = await http.post(Uri.parse(registrationUrl),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(regBody));

      //getting the response by the server
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];

        // passing token data to dashboard screen
      } else {
        print("Something went wrong");
      }
    }
  }

  void register(BuildContext context) {
    if (currentPageIndex.value == 2) {
      Navigator.pop(context);
      currentPageIndex.value == 0;
      return;
    }

    // Log every text editing controller in formate like - Feild Name - controller value

    if (0 == currentPageIndex.value) {
      if (nameController.text.isEmpty) {
        showErrorToast(
          context,
          "Name can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (registerationNoController.text.isEmpty) {
        showErrorToast(
          context,
          "Registeration No can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }
      if (emailController.text.isEmpty) {
        showErrorToast(
          context,
          "Email can't be empty",
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
      // email check for domain vitbhopal.ac.in
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
          "Password and Confirm Password should be same",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      log("Name - ${nameController.text}");
      log("Registeration No - ${registerationNoController.text}");
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

      if (Dob.value == "") {
        showErrorToast(
          context,
          "Dob can't be empty",
          animationCurve: Curves.fastLinearToSlowEaseIn,
        );
        return;
      }

      if ((DateTime.now().year - int.parse(Dob.value.split('-').last) < 16)) {
        showErrorToast(
          context,
          "Age should be less than 16",
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
      log("Registeration No - ${registerationNoController.text}");
      log("Email - ${emailController.text}");
      log("Password - ${passwordController.text}");
      log("CPassword - ${cpasswordController.text}");
      log("Phone - ${phoneController.text}");
      log("Gender - ${gender}");
      log("Joining Year - ${joiningYear.value}");
      log("Know From - ${knowFromController.text}");
      log("Dob - ${Dob.value.toString()}");

      registerUser();

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
      log("Is Verified - ${isVerified.value}");
      log("Can Resend - ${canResend.value}");
      log("Page Index - ${currentPageIndex.value}");
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
                initialDateTime: Dob.value == ""
                    ? DateTime(2000, 1, 1)
                    : DateFormat(format).parse(Dob.value),
                onDateTimeChanged: (DateTime dateTime) {
                  Dob.value = DateFormat(format).format(dateTime);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
