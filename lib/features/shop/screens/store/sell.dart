import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/features/shop/screens/store/create_product.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Sell Your Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const CreateProductScreen());
                  },
                  child: const Text('Sell Now'),
                ),
              ),
              TSectionHeading(
                title: 'Your Products',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SellProductCard(
                    isDone: index % 2 == 0,
                    name: 'Acer Laptop',
                    price: '₹ 2000',
                    image: TImages.acerlogo,
                    onView: () {
                      log('view $index');
                    },
                    onEdit: () {
                      log('edit $index');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SellProductCard extends StatelessWidget {
  const SellProductCard({
    super.key,
    this.isDone = false,
    required this.name,
    required this.price,
    this.onView,
    this.onEdit,
    required this.image,
  });

  final bool isDone;
  final String name;
  final String price;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final String image;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCirclularContainer(
      margen: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      padding: const EdgeInsets.all(TSizes.sm),
      width: TSizes.displayWidth(context),
      height: 180,
      radius: 12,
      backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
      child: Row(
        children: [
          TRoundedImage(
            imageUrl: image,
            width: 171,
            height: 171,
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              Row(
                children: [
                  Text(
                    "Status :",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: isDone ? TColors.warning : TColors.success,
                    ),
                    child: Text(
                      isDone ? "🕐 Pending" : "✅ Delivered",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: TColors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: TSizes.displayWidth(context) * 0.42,
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TCirclularContainer(
                        onTap: () => onView,
                        width: 40,
                        height: 40,
                        radius: 8,
                        backgroundColor: TColors.primary,
                        child: Center(
                          child: Text(
                            'View 👀',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                    Expanded(
                      child: TCirclularContainer(
                        onTap: () => onEdit,
                        width: 40,
                        height: 40,
                        radius: 8,
                        backgroundColor: TColors.primary,
                        child: Center(
                          child: Text(
                            'Edit 📝',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.sm,
              )
            ],
          ),
        ],
      ),
    );
  }
}
