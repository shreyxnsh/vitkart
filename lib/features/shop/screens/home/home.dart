import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/categoryScreens/eventCategoryScreen.dart';
import 'package:vitkart/features/events/screens/eventDetails.dart';
import 'package:vitkart/features/events/screens/widgets/tEventCategoryCard.dart';
import 'package:vitkart/features/shop/screens/categories/popular_products.dart';
import 'package:vitkart/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:vitkart/features/shop/screens/home/widgets/home_categories.dart';
import 'package:vitkart/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/api_routes.dart';

import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/staticData.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductData> products = [];
  late String userId;
  late String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();

    final userToken = GetStorage().read('token');

    if (userToken != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(userToken);

      // getting the user id of the user from db by variable _id from tokenData

      userId = jwtDecodedToken['userID'];
      userName = jwtDecodedToken['userName'];
      // userId = jwtDecodedToken['_id'];
      print("User token in HomeScreen is : $userToken");
      print("User ID in HomeScreen is : $userId");
      print("User Name in HomeScreen is : $userName");
    } else {
      // Handle the case where the token is null
      print("Token is null");
    }
  }

  Future<void> fetchAllProducts() async {
    final response = await http.get(Uri.parse(getAllProductUrl));
    print(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status']) {
        final List<dynamic>? productsData = data['products'];
        // log(productsData.toString());
        if (productsData != null) {
          final List<ProductData> fetchedProducts = productsData
              .map((product) => ProductData.fromJson(product))
              .toList();

          setState(() {
            products = fetchedProducts;
          });
        } else {
          // Handle the case where 'products' is null
          print('Products field is null');
        }
      }
    } else {
      // Handle error
      print('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              // height: TSizes.displayHeight(context) * 0.3,
              child: Column(
                children: [
                  /// App Bar
                  SizedBox(
                    height: 16,
                  ),
                  ThemeHomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),

                  // Search Bar
                  TSearchContainer(
                    text: "Search Event",
                    icon: Iconsax.search_normal,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections + 24,
                  ),
                  // category
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  TPromoSlider(
                    onTapRoutes: [
                      EventCategoryScreen(
                        data: SampleDataForUI.eventCategoryData,
                        categoryName: "Advitya 2024",
                      ),
                      EventCategoryScreen(
                        data: SampleDataForUI.eventCategoryData,
                        categoryName: "Advitya 2024",
                      ),
                      EventCategoryScreen(
                        data: SampleDataForUI.eventCategoryData,
                        categoryName: "Advitya 2024",
                      ),
                    ],
                    banners: const [
                      TImages.promoBanner1,
                      TImages.promoBanner1,
                      TImages.promoBanner1,
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSectionHeading(
                    title: "Advitya 2024 ",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const PopularProductScreen());
                    },
                  ),
                  PopularEventList(
                      data:
                          SampleDataForUI.horizontalScrollCardsEventsCategory),
                  TSectionHeading(
                    title: "Upcoming Events",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const PopularProductScreen());
                    },
                  ),
                  PopularEventList(
                      data:
                          SampleDataForUI.horizontalScrollCardsEventsCategory),
                  TSectionHeading(
                    title: "Popular Events",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const PopularProductScreen());
                    },
                  ),
                  PopularEventList(
                      data:
                          SampleDataForUI.horizontalScrollCardsEventsCategory),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
