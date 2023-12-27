import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/config/config.dart';

class RegisterController extends GetxController {
  // page one
  TextEditingController nameController = TextEditingController();
  TextEditingController registerationNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  //page two
  TextEditingController phoneController = TextEditingController();
  TextEditingController joiningYearController = TextEditingController();
  TextEditingController knowFromController = TextEditingController();
  Rx<DateTime> dob = DateTime.now().obs;
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
    joiningYearController.dispose();
    knowFromController.dispose();
    pageController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // currentPageIndex.value = 0;
  }

    void registerUser() async{
    // check if user has added data
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      // creating an object of registration body
      var regBody = {
        //json format
        "userEmail":emailController.text,
        "userPassword":passwordController.text,
        "userRegID":registerationNoController.text,
        "userName":nameController.text,
      };

      print(regBody);

      // http [post] request sent to api
      var response = await http.post(Uri.parse(registrationUrl),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(regBody)
      );

      //getting the response by the server
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if(jsonResponse['status']){
        
        var myToken = jsonResponse['token'];
 
        
        // passing token data to dashboard screen
       

      }else{
        print("Something went wrong");
      };
    }

  }



  void register() {
    if (currentPageIndex.value == 2) {
      Get.to(const LoginScreen());
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
      log("Joining Year - ${joiningYearController.text}");
      log("Know From - ${knowFromController.text}");
      log("Dob - ${dob.toString()}");

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

  void dobPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      dob.value = value;
      log(value.toString());
      log(dob.value.toString());
    });
  }
}
