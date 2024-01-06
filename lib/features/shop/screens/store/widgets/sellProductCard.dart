import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';


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
      padding: const EdgeInsets.fromLTRB(
        TSizes.sm,
        TSizes.sm,
        TSizes.sm,
        TSizes.sm,
      ),
      width: TSizes.displayWidth(context),
      height: 180,
      radius: 12,
      backgroundColor: dark ? TColors.lightDarkBackground : TColors.light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       


          TRoundedContainer(
                        height: TSizes.displayWidth(context) * (160 / 420),
                        width: TSizes.displayWidth(context) * (150 / 420),
                        
                        clipBehavior: Clip.antiAlias,
                        backgroundColor:
                            dark ? TColors.lightDarkBackground : TColors.light,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.network(
                                image,
                                width: 200,
                                height: double.infinity,
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    
                                    return child;
                                  } else {
                                    // You can return a placeholder or a loading indicator here
                                    return const CircularProgressIndicator();
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  // You can return an error placeholder or handle errors here
                                  return const Icon(Icons
                                      .error); // Example: Show an error icon
                                },
                              ),
                            ),
                            // ... Other parts of the Stack
                          ],
                        ),
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
                        width: TSizes.displayWidth(context) * (40 / 420),
                        height: TSizes.displayWidth(context) * (40 / 420),
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
                        width: TSizes.displayWidth(context) * (40 / 420),
                        height: TSizes.displayWidth(context) * (40 / 420),
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
