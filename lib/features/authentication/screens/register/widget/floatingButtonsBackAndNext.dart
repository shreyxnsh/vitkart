import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vitkart/features/authentication/controllers/register/register_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';

class FloatingBackNextButton extends StatelessWidget {
  const FloatingBackNextButton({
    super.key,
    required this.controller,
    this.endTextLabel,
    required this.currentPageIndex,
    this.onNext,
    this.onBack,
  });

  final RegisterController controller;
  final String? endTextLabel;
  final int currentPageIndex;
  final void Function()? onNext;
  final void Function()? onBack;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: onBack,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size.square(54),
                    maximumSize: const Size.square(54),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.arrow_left_2,
                      color: TColors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Check if the loading animation is already running
                    if (!controller.isLoading.value) {
                      // Call the onNext function only if not loading
                      onNext?.call();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size.fromHeight(54),
                    maximumSize: const Size.fromHeight(54),
                  ),
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        // Show loading animation if isLoading is true
                        Visibility(
                          visible: controller.isLoading.value,
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        // Show button text when not loading
                        Visibility(
                          visible: !controller.isLoading.value,
                          child: Text(
                            currentPageIndex == 2
                                ? endTextLabel ?? "Done"
                                : "Next",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

