import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/rating_share_button.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBootomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 Product Image Slider
            const TProductImageSlider(),

            // 2 Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // Rating and Share Button
    

                  /// - Price,Title ,Stock & Brand
                  const TProductMetaData(),

                  /// -- Attributes
                  const TProductAttributes(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                

                  /// - Descriptioon
                  const TSectionHeading(title: "Discription"),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    "Introducing our latest innovation: The QuantumX Pro Series Smart Speaker. Elevate your audio experience to new heights with cutting-edge technology and sleek design. Immerse yourself in crystal-clear sound quality that resonates in every corner of your space. The QuantumX Pro is equipped with state-of-the-art audio engineering, delivering deep bass, crisp highs, and a rich midrange. Whether you're hosting a party, working from home, or simply enjoying your favorite tunes, this smart speaker ensures an unparalleled audio journey.\n With seamless Bluetooth connectivity, effortlessly pair your devices and enjoy wireless freedom. The QuantumX Pro also boasts a built-in voice assistant, allowing you to control your music, check the weather, or set reminders with just the sound of your voice.\n Designed with both aesthetics and functionality in mind, the sleek and modern exterior of the QuantumX Pro Series Smart Speaker seamlessly blends into any environment. Its compact size makes it perfect for on-the-go adventures, yet its powerful performance ensures it's the life of the party.\nUpgrade your audio experience with the QuantumX Pro Series Smart Speaker – where innovation meets sound. Elevate your senses and redefine how you experience music and entertainment.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: "\n\nShow less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
