import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  RxDouble cooldownTimer = 0.0.obs;
  double _resendCooldownTimer = 1;
  Timer? _timer;
  RxBool _verifyingOtp = false.obs;

  RxBool _newPassword = false.obs;
  RxBool _confirmPassword = false.obs;

  RxBool mainButtonLoad = false.obs;

  // convert seconds to minutes in timer formate (mm:ss)
  String get timerString {
    final minutes =
        (cooldownTimer.value / 60).floor().toString().padLeft(2, '0');
    final seconds =
        (cooldownTimer.value % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  final PageController _pageController = PageController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  Future<bool> verifyOtp(String pin, String email) async {
    _verifyingOtp.value = true;
    Map<String, dynamic> response =
        await APIFunctions.verifyOtp(email: email, pin: pin);
    if (response['isSuccess'] == false) {
      showErrorToast(context, response['message']);
      _verifyingOtp.value = false;
      return false;
    }
    showSuccessToast(context, response['message']);
    _verifyingOtp.value = false;
    return true;
  }

  void startTimer(double time) {
    cooldownTimer.value = time;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (cooldownTimer.value == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            cooldownTimer.value--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Forget Password"),
        showBackArrow: false,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_pageController.page!.round() == 0) {
            Get.offAll(() => const LoginScreen());
            return;
          }

          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text("Exit"),
                content:
                    const Text("Are you sure you want to exit the process!!"),
                actions: [
                  CupertinoDialogAction(
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: TColors.primary),
                      ),
                      onPressed: () {
                        Get.offAll(() => const LoginScreen());
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
        child: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              Page1(context),
              Page2(context),
              Page3(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget Page1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter your email address to reset your password",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginScreenTextFeild(
            controller: _emailController,
            labelText: "Email",
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const Spacer(),
          Hero(
            tag: "loginButton",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
                minimumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
              ),
              onPressed: () async {
                if (mainButtonLoad.value) {
                  return;
                }
                if (_emailController.text.trim().isEmpty) {
                  showErrorToast(context, "Email cannot be empty");
                  return;
                }
                if (GetUtils.isEmail(_emailController.text.trim()) == false ||
                    _emailController.text.trim().split("@").last !=
                        'vitbhopal.ac.in' ||
                    _emailController.text.trim().contains('+')) {
                  log("Invalid Emai ${_emailController.text.trim()}");
                  showErrorToast(context, "Invalid Email");
                  return;
                }

                // Map<String, dynamic> response = {
                //   "isSuccess": true,
                //   "message": "OTP sent successfully"
                // };
                mainButtonLoad.value = true;
                Map<String, dynamic> response =
                    await APIFunctions.sendPasswordResetRequest(
                        email: _emailController.text.trim());
                mainButtonLoad.value = false;
                if (response['isSuccess'] == false) {
                  showErrorToast(context, response['message']);
                  return;
                }
                showSuccessToast(context, response['message']);

                // srart the timer
                startTimer(cooldownTimer.value = 60 * _resendCooldownTimer++);

                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Obx(
                () {
                  if (mainButtonLoad.value) {
                    return LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 30,
                    );
                  }
                  return const Text("Send");
                },
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget Page2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Use TextSpan widget to style the email text saperately from the rest of the text

          Text.rich(
            TextSpan(
              text: "Enter the OTP sent to your email ",
              children: [
                TextSpan(
                  text: _emailController.text.trim(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const TextSpan(text: " address to reset your password"),
              ],
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: 48,
          ),
          Pinput(
            controller: _otpController,
            defaultPinTheme: defaultPinTheme,
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration?.copyWith(
                color: _otpController.text.length == 4
                    ? const Color.fromRGBO(206, 255, 210, 1)
                    : const Color.fromRGBO(234, 239, 243, 1),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            length: 4,
            onChanged: (s) {},
            onClipboardFound: (pin) {
              log("OTP from clipboard $pin");

              // show a pop up asking the user if they want to use the otp from the clipboard

              showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text("OTP Found"),
                      content: Text(
                          "Do you want to use the OTP $pin from the clipboard"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Yes"),
                          onPressed: () {
                            _otpController.text = pin;
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });

              // _otpController.text = pin;
            },
            errorBuilder: (String? errorText, String pin) {
              return Text(
                errorText ?? "",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: TColors.error,
                    ),
              );
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) async {
              log("OTP completed $pin");

              bool verified =
                  await verifyOtp(pin, _emailController.text.trim());
              if (verified == false) {
                return;
              }
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
          ),

          const SizedBox(
            height: 48,
          ),
          // Resend Button with cooldown timer

          Obx(() {
            if (cooldownTimer.value == 0) {
              return TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.linearGRadient2,
                  maximumSize: Size(TSizes.displayWidth(context) * 0.2, 42),
                  minimumSize: Size(TSizes.displayWidth(context) * 0.2, 42),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: TColors.primary, width: 1.5)),
                ),
                onPressed: () async {
                  Map<String, dynamic> response =
                      await APIFunctions.sendPasswordResetRequest(
                          email: _emailController.text.trim());
                  if (response['isSuccess'] == false) {
                    showErrorToast(context, response['message']);
                    return;
                  }
                  showSuccessToast(context, response['message']);

                  startTimer(cooldownTimer.value = 60 * _resendCooldownTimer++);
                  log("Resend cooldown timer $cooldownTimer.value");

                  // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                  //   if (_cooldownTimer == 0) {
                  //     _timer?.cancel();
                  //   } else {
                  //     setState(() {
                  //       _cooldownTimer = _cooldownTimer - 1;
                  //     });
                  //   }
                  // });

                  // _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
                  //   if (_cooldownTimer == 0) {
                  //     _timer?.cancel();
                  //   } else {
                  //     setState(() {
                  //       _cooldownTimer = timer.tick.toDouble();
                  //     });
                  //   }
                  // });
                },
                child: const Text(
                  "Resend",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            } else
              return Text(
                "Resend otp in ${timerString}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              );
          }),
          // edit email button
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Wrong Email?  ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              InkWell(
                onTap: () {
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Text(
                  "Edit Email",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),
          Hero(
            tag: "loginButton",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
                minimumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
              ),
              onPressed: () async {
                if (_verifyingOtp.value == true) {
                  return;
                }
                if (_otpController.text.trim().isEmpty) {
                  showErrorToast(context, "OTP cannot be empty");
                  return;
                }

                bool isVerified = await verifyOtp(
                    _otpController.text.trim(), _emailController.text.trim());
                if (isVerified == false) {
                  return;
                }
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Obx(() {
                if (_verifyingOtp.value == true) {
                  return LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 30,
                  );
                } else {
                  return const Text("Verify OTP");
                }
              }),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget Page3(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Obx(
        () => Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Enter the OTP sent to your email (${_emailController.text}) address to reset your password",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            LoginScreenTextFeild(
              controller: _newPasswordController,
              labelText: "New Password",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _newPassword.value,
              suffixIcon: GestureDetector(
                onTap: () {
                  _newPassword.value = !_newPassword.value;
                },
                child: Icon(
                    _newPassword.value ? Iconsax.eye_slash : Iconsax.eye,
                    size: 18,
                    color: _newPassword.value
                        ? TColors.white
                        : Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            LoginScreenTextFeild(
              controller: _confirmPasswordController,
              labelText: "Confirm Password",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _confirmPassword.value,
              suffixIcon: GestureDetector(
                onTap: () {
                  _confirmPassword.value = !_confirmPassword.value;
                },
                child: Icon(
                    _confirmPassword.value ? Iconsax.eye_slash : Iconsax.eye,
                    size: 18,
                    color: _confirmPassword.value
                        ? TColors.white
                        : Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                maximumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
                minimumSize: Size(TSizes.displayWidth(context) * 0.72, 54),
              ),
              onPressed: () async {
                if (_newPasswordController.text.trim().isEmpty) {
                  showErrorToast(context, "New Password cannot be empty");
                  return;
                }

                if (_confirmPasswordController.text.trim().isEmpty) {
                  showErrorToast(context, "Confirm Password cannot be empty");
                  return;
                }

                if (_newPasswordController.text.trim() !=
                    _confirmPasswordController.text.trim()) {
                  showErrorToast(context, "Passwords do not match");
                  return;
                }

                if (_otpController.text.trim().isEmpty) {
                  showErrorToast(context, "OTP cannot be empty");
                  return;
                }
                mainButtonLoad.value = true;

                Map<String, dynamic> response = await APIFunctions.newPassword(
                  email: _emailController.text.trim(),
                  newPassword: _newPasswordController.text.trim(),
                );
                mainButtonLoad.value = false;
                if (response['isSuccess'] == false) {
                  showErrorToast(context, response['message']);
                  return;
                }
                showSuccessToast(context, response['message']);

                Get.offAll(() => const LoginScreen());
              },
              child: Obx(() {
                if (mainButtonLoad.value) {
                  return LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 30,
                  );
                }
                return const Text("Set New Password");
              }),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
