import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/common/widgets/text/t_brand_title_with_verifiedicon.dart';
import 'package:vitkart/features/shop/screens/product_details/product_detail.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatefulWidget {
  final ProductData product;

  const TProductCardVertical({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {
  bool shimmerIt = true;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final baseColor =
        dark ? TColors.darkBackground.withOpacity(0.4) : TColors.light;
    final highlightColor = dark ? TColors.grey.withOpacity(0.2) : TColors.light;

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.lightDarkBackground : TColors.light,
        ),
        child: shimmerIt
            ? Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      child: TRoundedContainer(
                        height: TSizes.productItemHeight + 10,
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(TSizes.xs),
                        clipBehavior: Clip.antiAlias,
                        backgroundColor:
                            dark ? TColors.lightDarkBackground : TColors.light,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.network(
                                widget.product.productImage,
                                width: 200,
                                height: 350,
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    Future.delayed(Duration.zero, () {
                                      setState(() {
                                        shimmerIt = false;
                                      });
                                    });
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
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: TColors.accent,
                              ),
                              width: 100,
                              height: 16,
                            ),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: TColors.accent,
                              ),
                              width: 80,
                              height: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: TSizes.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: TColors.accent,
                              ),
                              width: 36,
                              height: 16,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: TColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(TSizes.productImageRadius),
                              ),
                            ),
                            child: const SizedBox(
                              width: TSizes.iconLg * 1.2,
                              height: TSizes.iconLg * 1.2,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: TColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(TSizes.xs),
                    child: TRoundedContainer(
                      height: TSizes.productItemHeight + 10,
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.all(TSizes.xs),
                      clipBehavior: Clip.antiAlias,
                      backgroundColor:
                          dark ? TColors.lightDarkBackground : TColors.light,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.network(
                              widget.product.productImage,
                              width: 200,
                              height: 300,
                              fit: BoxFit.fitHeight,
                              // loadingBuilder: (BuildContext context,
                              //     Widget child,
                              //     ImageChunkEvent? loadingProgress) {
                              //   if (loadingProgress == null) {
                              //     setState(() {
                              //       shimmerIt = false;
                              //     });
                              //     return child;
                              //   } else {
                              //     // You can return a placeholder or a loading indicator here
                              //     return const CircularProgressIndicator();
                              //   }
                              // },
                              // errorBuilder: (BuildContext context, Object error,
                              //     StackTrace? stackTrace) {
                              //   // You can return an error placeholder or handle errors here
                              //   return const Icon(
                              //       Icons.error); // Example: Show an error icon
                              // },
                            ),
                          ),
                          // ... Other parts of the Stack
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerIt
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: TColors.accent,
                                  ),
                                  width: 100,
                                  height: 16,
                                ),
                              )
                            : TProductTitleText(
                                title: widget.product.productName,
                                smallSize: true,
                              ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        shimmerIt
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: TColors.accent,
                                  ),
                                  width: 80,
                                  height: 16,
                                ),
                              )
                            : TBrandTitleWithVerifiedIcon(
                                title: widget.product.sellerName,
                              ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        shimmerIt
                            ? Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: TColors.accent,
                                  ),
                                  width: 36,
                                  height: 16,
                                ),
                              )
                            : TProductPriceText(
                                price: widget.product.productPrice.toString(),
                              ),
                        Container(
                          decoration: const BoxDecoration(
                            color: TColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: TColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ProductData {
  final String id;
  final String productName;
  final String productDesc;
  final String productImage;
  final List<String> productCategory;
  final double productPrice;
  final int productStock;
  final bool isPopular;
  final String sellerName;
  final String productStatus;

  ProductData({
    required this.id,
    required this.productName,
    required this.productDesc,
    required this.productImage,
    required this.productCategory,
    required this.productPrice,
    required this.productStock,
    required this.isPopular,
    required this.sellerName,
    required this.productStatus,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      productName: json['productName'],
      productDesc: json['productDesc'],
      productImage: json['productImages'][0],
      productCategory: List<String>.from(json['productCategory']),
      productPrice: json['productPrice'].toDouble(),
      productStock: json['productStock'],
      isPopular: json['isPopular'],
      sellerName: json['sellerName'],
      productStatus: json['productStatus'],
    );
  }
}
