import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
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
import 'package:vitkart/utils/constants/colors.dart';

import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/staticData.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';
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

  Future<Map<String, dynamic>> getBanners() async {
    Map<String, dynamic> response = await APIFunctions.getBanners();
    // await Future.delayed(Duration(seconds: 40));
    if (response['isSuccess'] == true) {
      return response;
    }
    return {};
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
                  FutureBuilder(
                    future: getBanners(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            ...List.generate(
                              2,
                              (index) => Shimmer.fromColors(
                                baseColor: TColors.lightDarkBackground
                                    .withOpacity(0.4),
                                highlightColor: TColors.grey.withOpacity(0.18),
                                child: TRoundedContainer(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: TSizes.defaultSpace),
                                  radius: 12,
                                  backgroundColor: TColors.light,
                                  height: TSizes.displayHeight(context) * 0.24,
                                  width: TSizes.displayWidth(context) * 0.8,
                                ),
                              ),
                            ),
                          ]),
                        );
                      }
                      return TPromoSlider(
                        onTapRoutes: [
                          ...List.generate(
                            (snapshot.data!['banners'] ?? 0).length,
                            (index) {
                              return EventCategoryScreen(
                                data: SampleDataForUI.eventCategoryData,
                                categoryName: snapshot.data!['banners'][index]
                                    ['bannerTitle'],
                              );
                            },
                          )
                        ],
                        banners: [
                          ...List.generate(
                            (snapshot.data!['banners'] ?? 0).length,
                            (index) {
                              return snapshot.data!['banners'][index]
                                  ['bannerImage'][0];
                            },
                          )
                        ],
                      );
                    },
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
                  EventsHorizontalListFromAPI(category: 'advitya'),
                  TSectionHeading(
                    title: "Upcoming Events",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const PopularProductScreen());
                    },
                  ),
                  EventsHorizontalListFromAPI(),
                  TSectionHeading(
                    title: "Popular Events",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const PopularProductScreen());
                    },
                  ),
                  EventsHorizontalListFromAPI(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventsHorizontalListFromAPI extends StatelessWidget {
  EventsHorizontalListFromAPI({
    super.key,
    this.category,
  });

  String? category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FutureBuilderFunctions.fetchAdvityaEvents(category),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TSizes.defaultSpace,
            ),
            child: Shimmer.fromColors(
              baseColor: TColors.lightDarkBackground.withOpacity(0.4),
              highlightColor: TColors.grey.withOpacity(0.18),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: TColors.lightDarkBackground,
                  borderRadius: BorderRadius.circular(
                    TSizes.cardRadiusLg,
                  ),
                ),
              ),
            ),
          );
        }
        return PopularEventList(
          data: snapshot.requireData['events'],
        );
      },
    );
  }
}
