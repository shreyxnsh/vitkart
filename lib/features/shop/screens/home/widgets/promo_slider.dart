import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/features/shop/controllers/home_controller.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
    required this.onTapRoutes,
  });

  final List<String> banners;
  final List<Widget> onTapRoutes;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayInterval: const Duration(seconds: 5),
            pauseAutoPlayOnManualNavigate: true,
            autoPlay: true,
            onPageChanged: (index, _) => controller.carousalCurrentIndex(index),
          ),
          items: List.generate(
            onTapRoutes.length,
            (index) => TRoundedImage(
              width: TSizes.displayWidth(context) * 0.85,
              height: TSizes.displayWidth(context) * 0.4,
              fit: BoxFit.fill,
              imageUrl: banners[index],
              onPressed: () => Get.to(onTapRoutes[index]),
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TCirclularContainer(
                    width: 20,
                    height: 4,
                    margen: const EdgeInsets.only(right: 10),
                    backgroundColor: i == controller.carousalCurrentIndex.value
                        ? TColors.primary
                        : TColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
