import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/icons/t_circular_icon.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/product_title_text.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:vitkart/features/shop/screens/product_details/widgets/rating_share_button.dart';
import 'package:vitkart/features/shop/screens/store/widgets/bidder_card.dart';
import 'package:vitkart/features/shop/screens/store/widgets/buyer_card.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class SellStatsScreen extends StatefulWidget {
  final ProductData product;

  const SellStatsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SellStatsScreen> createState() => _SellStatsScreenState();
}

class _SellStatsScreenState extends State<SellStatsScreen> {
  late Stream<Map<String, dynamic>> _biddersStream;
  late Stream<Map<String, dynamic>> _buyersStream;
  late Map<String, dynamic> _biddersData;
  late Map<String, dynamic> _buyersData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    Map<String, dynamic> data =
        await APIFunctions.getBiddersList(widget.product.id.toString());
    setState(() {
      _biddersData = data;
      _biddersStream = Stream.value(data);
    });

    data = await APIFunctions.getBiddersList(widget.product.id.toString());
    setState(() {
      _buyersData = data;
      _buyersStream = Stream.value(data);
    });
  }

  Stream _fetchList() async* {
    log(widget.product.id.toString());
    Map<String, dynamic> data =
        await APIFunctions.getBiddersList(widget.product.id.toString());
    if (data['isSuccess']) {
      log("this is ---" + data.toString());
      yield data;
    }
    yield {};
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // bottomNavigationBar: TBottomAddToCart(),
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
                      height: 420,
                      child: Padding(
                        padding: EdgeInsets.all(TSizes.productImageRadius),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: widget.product.productImage[0],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
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
              padding: EdgeInsets.only(
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
                                TRoundedContainer(
                                  radius: TSizes.sm,
                                  backgroundColor:
                                      TColors.secondary.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.sm,
                                      vertical: TSizes.xs),
                                  child: Text(
                                    "25 %",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .apply(color: TColors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                // Price
                                Text(
                                  "\$${widget.product.productPrice}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
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
                              onPressed: () {},
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
                  TSectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    "${widget.product.productDesc}",
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: "\n\nShow less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: "Buyer",
                    showActionButton: false,
                  ),

                  /// - Reviews
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // BuyerCard(
                  //   name: "Shreyansh Jain",
                  //   email: "shreyansh@gmail.com",
                  //   regId: "21BSA10012",
                  //   onTap: () {
                  //     log('Approve');
                  //   },
                  // ),

                  StreamBuilder<Map<String, dynamic>>(
                    stream: _buyersStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      var data = snapshot.data ?? {};
                      if (!data.containsKey('status') || !data['status']) {
                        return Center(
                            child: Text('Error: Unable to fetch data'));
                      }
                      var buyerId = data['product']['buyerId'];
                      if (buyerId == null) {
                        return Center(child: Text('No buyer found'));
                      }
                      return BuyerCard(
                        name: buyerId['userName'],
                        email: buyerId['userEmail'],
                        regId: buyerId['userContact'],
                        onTap: () async {
                          // Handle onTap event
                          log('Remove');
                          Map<String, dynamic> response =
                              await APIFunctions.removeBid(
                                  productId: widget.product.id,
                                  buyerId: buyerId['_id']);
                          log("Remove Response : $response");
                          _fetchData();
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // Bidders
                  TSectionHeading(
                    title: "Bidders",
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  StreamBuilder<Map<String, dynamic>>(
                    stream: _biddersStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      var data = snapshot.data ?? {};
                      if (!data.containsKey('status') || !data['status']) {
                        return Center(
                            child: Text('Error: Unable to fetch data'));
                      }
                      var bidderId = data['product']['bidderId'];
                      if (bidderId.isEmpty) {
                        return Center(child: Text('No bidders found'));
                      }
                      return Column(
                        children: bidderId
                            .map<Widget>((bidder) => Column(
                                  children: [
                                    BidderCard(
                                      name: bidder['userName'],
                                      email: bidder['userEmail'],
                                      regId: bidder['userContact'],
                                      onTap: () async {
                                        log('Approve');
                                        Map<String, dynamic> response =
                                            await APIFunctions.approveBit(
                                                productId: widget.product.id,
                                                bidderId: bidder['_id']);
                                        log("Approve Response : $response");
                                        // Refresh the data after approving bidder
                                        _fetchData();
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ))
                            .toList(),
                      );
                    },
                  ),

                  /// - Reviews
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
