import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/categories/popular_products.dart';
import 'package:vitkart/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:vitkart/features/shop/screens/home/widgets/home_categories.dart';
import 'package:vitkart/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late String userId;
  late String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userToken = GetStorage().read('token');

    if (userToken != null) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(userToken);

    // getting the user id of the user from db by variable _id from tokenData

    userId = jwtDecodedToken['userID'];
    userName = jwtDecodedToken['userName'];
    // userId = jwtDecodedToken['_id'];
    print("User token in HomeScreen is : ${userToken}");
    print("User ID in HomeScreen is : $userId");
    print("User Name in HomeScreen is : $userName");
  } else {
    // Handle the case where the token is null
    print("Token is null");
  }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              height: 370,
              child: Column(
                children: [
                  /// App Bar
                  SizedBox(
                    height: 16,
                  ),
                  ThemeHomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// Search Bar
                  TSearchContainer(
                    text: "Search in Store",
                    icon: Iconsax.search_normal,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  // category
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: "Popular Categories",
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        THomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  const TPromoSlider(banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                  ]),
                  const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                  TSectionHeading(
                          title: "Popular Products",
                          showActionButton: true,
                         
                          onPressed: (){
                            Get.to(const PopularProductScreen());
                          },
                        ),
                        
                  TGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const TProductCardVertical(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
