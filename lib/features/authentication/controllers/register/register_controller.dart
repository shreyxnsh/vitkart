import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
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
  late DropListModel joiningYearList;

  RxInt joiningYear = 0.obs;
  Rx<String> gender = "unKnown".obs;
  TextEditingController knowFromController = TextEditingController();
  Rx<String> Dob = "".obs;

  // Page three
  TextEditingController otpController = TextEditingController();
  RxBool isVerified = false.obs;
  RxBool canResend = true.obs;

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
    List<OptionItem> lst = [];
    for (int i = DateTime.now().year - 4; i <= DateTime.now().year; i++) {
      lst.add(OptionItem(
        title: i.toString(),
        id: i.toString(),
      ));
    }
    joiningYearList = DropListModel(lst);
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
    pageController.animateToPage(
      currentPageIndex.value + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    // Log every text editing controller in formate like - Feild Name - controller value

    if (0 == currentPageIndex.value) {
      log("Name - ${nameController.text}");
      log("Registeration No - ${registerationNoController.text}");
      log("Email - ${emailController.text}");
      log("Password - ${passwordController.text}");
      log("CPassword - ${cpasswordController.text}");
      log("Phone - ${phoneController.text}");
    }
    if (1 == currentPageIndex.value) {
      log("Name - ${nameController.text}");
      log("Registeration No - ${registerationNoController.text}");
      log("Email - ${emailController.text}");
      log("Password - ${passwordController.text}");
      log("CPassword - ${cpasswordController.text}");
      log("Phone - ${phoneController.text}");
      log("Joining Year - ${joiningYear.value}");
      log("Know From - ${knowFromController.text}");
      log("Dob - ${Dob.value.toString()}");

      registerUser();
    }
    if (2 == currentPageIndex.value) {
      log("Otp - ${otpController.text}");
      log("Is Verified - ${isVerified.value}");
      log("Can Resend - ${canResend.value}");
      log("Page Index - ${currentPageIndex.value}");
    }

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

  void dobPicker(BuildContext context, Color bgColor) async {
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
                    : DateFormat(DateFormat.YEAR_MONTH_DAY).parse(Dob.value),
                onDateTimeChanged: (DateTime dateTime) {
                  Dob.value =
                      DateFormat(DateFormat.YEAR_MONTH_DAY).format(dateTime);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
