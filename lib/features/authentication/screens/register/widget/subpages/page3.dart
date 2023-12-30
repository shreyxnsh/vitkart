import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class Page3 extends StatelessWidget {
  const Page3({
    super.key,
    required this.controller,
    required this.defaultPinTheme,
  });

  final RegisterController controller;
  final PinTheme defaultPinTheme;

  String countdownFormat(double time) {
    return "${(time / 60).toString().split(".").first}:${(time % 60) < 10 ? "0${(time % 60).toString().split(".").first}" : (time % 60).toString().split(".").first}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: TSizes.spaceBtwItems),
          Center(
            child: Text(
              "OTP Verification",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(fontSizeFactor: 1.2, fontWeightDelta: 1),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "We just sent a 4-digit code to ${controller.emailController.text} . Enter the code below.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(fontSizeFactor: 0.9),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Center(
            child: Pinput(
              controller: controller.otpController,
              defaultPinTheme: defaultPinTheme,
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration?.copyWith(
                  color: controller.isVerified.value
                      ? const Color.fromRGBO(206, 255, 210, 1)
                      : const Color.fromRGBO(234, 239, 243, 1),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              length: 4,
              onChanged: (s) {
                if (s == "2222") {
                  controller.isVerified.value = true;
                } else {
                  controller.isVerified.value = false;
                }
              },
              validator: (s) {
                return null;

                // if (s == "2222") {
                //   controller.isVerified.value = true;
                // } else {
                //   controller.isVerified.value = false;
                // }
                // return null;
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => controller.countdown.value == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive code?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          controller.resendOTP();
                        },
                        child: Text(
                          "Resend",
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: controller.canResend.value
                                  ? TColors.primary
                                  : TColors.grey,
                              fontSizeFactor: 0.9),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Countdown(
                      seconds: controller.countdown.value,
                      build: (BuildContext context, double time) => Text(
                        "You can resend in ${countdownFormat(time)}",
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: TColors.darkGrey,
                              fontSizeFactor: 0.9,
                            ),
                      ),
                      interval: const Duration(seconds: 1),
                      controller: CountdownController(
                        autoStart: true,
                      ),
                      onFinished: () {
                        controller.countdown.value = 0;
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
