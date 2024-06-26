import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/icons/t_circular_icon.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/rating_share_button.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductData product;

  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {


  //  Future<void> share() async {
  //   await FlutterShare.share(
  //     title: 'Example share',
  //     text: 'Example share text',
  //     linkUrl: 'https://flutter.dev/',
  //     chooserTitle: 'Example Chooser Title'
  //   );
  // }
  
  @override
  Widget build(BuildContext context) {

    final box = context.findRenderObject() as RenderBox?;
    log("Product Detail Screen   ${widget.product.productImage.length}");
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TBottomAddToCart(
          productId: widget.product,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            TCurverEdgesWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    // Main Large Image

                    SizedBox(
                      height: TSizes.displayWidth(context),
                      child: PageView(
                        children: List.generate(
                          widget.product.productImage.length,
                          (index) => Center(
                            child: CachedNetworkImage(
                              imageUrl: widget.product.productImage[index],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: TSizes.displayWidth(context),
                    //   child: Padding(
                    //     padding: EdgeInsets.all(0),
                    //     child: Center(
                    //       child: CachedNetworkImage(
                    //         imageUrl: widget.product.productImage[0],
                    //         placeholder: (context, url) =>
                    //             CircularProgressIndicator(),
                    //         errorWidget: (context, url, error) =>
                    //             Icon(Icons.error),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Image Slider
                    // Positioned(
                    //   right: 0,
                    //   bottom: 30,
                    //   left: TSizes.defaultSpace,
                    //   child: Column(
                    //     children: [
                    //       SizedBox(
                    //         height: 80,
                    //         child: ListView.separated(
                    //           shrinkWrap: true,
                    //           scrollDirection: Axis.horizontal,
                    //           physics: const AlwaysScrollableScrollPhysics(),
                    //           itemCount: widget.product.productImage.length,
                    //           separatorBuilder: (_, __) =>
                    //               const SizedBox(width: TSizes.spaceBtwItems),
                    //           itemBuilder: (_, index) => TRoundedImage(
                    //             width: 80,
                    //             backgroundColor:
                    //                 dark ? TColors.dark : TColors.white,
                    //             border: Border.all(
                    //               color: TColors.primary,
                    //             ),
                    //             padding: const EdgeInsets.all(TSizes.sm),
                    //             imageUrl: widget.product.productImage[index],
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Appbar Icon
                    const TAppBar(
                      showBackArrow: true,
                      actions: [
                        TCircularIcon(
                          icon: Iconsax.heart5,
                          color: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and Share Button
                  /// - Price,Title ,Stock & Brand
                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor:
                        dark ? TColors.lightDarkBackground : TColors.light,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Price & Sale Price
                        Row(
                          children: [
                            /// Sale tag
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                // Price
                                Text(
                                  "Price : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                TProductPriceText(
                                  price: "${widget.product.productPrice}",
                                  isLarge: true,
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                log("Share Button Pressed");
                                // SharedAppData(child: )
                                // share();
                                //  await Share.share('check out my website https://example.com');
                              },
                              icon: const Icon(
                                Icons.share,
                                size: TSizes.iconMd,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),

                        /// Titile
                        TProductTitleText(
                          title: widget.product.productName,
                          smallSize: false,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),

                        /// Stock Status
                        Row(
                          children: [
                            const TProductTitleText(
                              title: "Quantity :",
                              smallSize: true,
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            Text(
                              "${widget.product.productStock}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// - Description
                  const TSectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    widget.product.productDesc,
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: "\n\nShow less",
                    moreStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// - Reviews
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
