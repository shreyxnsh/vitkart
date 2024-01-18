import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/images/t_rounded_image.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/home/widgets/circular_widget.dart';
import 'package:vitkart/features/shop/screens/store/create_product.dart';
import 'package:vitkart/features/shop/screens/store/widgets/sellProductCard.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/API/api_routes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  List<ProductData> products = [];
  final sellerName = UserDataService.getUserName();

  @override
  void initState() {
    super.initState();
    fetchUserProducts();
  }

  Future<void> fetchUserProducts() async {
    final response = await http.get(Uri.parse('$getUserProducts$sellerName'));
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status']) {
        final List<dynamic> productsData = data['products'];
        final List<ProductData> fetchedProducts = productsData
            .map((product) => ProductData.fromJson(product))
            .toList();

        setState(() {
          products = fetchedProducts;
        });
      }
    } else {
      // Handle error
      print('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Sell your Products',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: false,
      ),
      body: Center(
        child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Center(
                child: Text(
                  "Uh Oh! Wait for the V2 launch...  🧑🏻‍💻",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: TColors.primary,
                      ),
                ),
              ),
            )
        
        
        // Padding(
        //   padding: const EdgeInsets.all(TSizes.defaultSpace),
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         width: double.infinity,
        //         child: ElevatedButton(
        //           onPressed: () {
        //             Get.to(() => const CreateProductScreen());
        //           },
        //           child: const Text('Sell Now'),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: TSizes.spaceBtwItems,
        //       ),
        //       TSectionHeading(
        //         title: 'Your Products',
        //         showActionButton: true,
        //         onPressed: () {},
        //       ),
        //       const SizedBox(
        //         height: TSizes.spaceBtwItems,
        //       ),
        //       ListView.builder(
        //         shrinkWrap: true,
        //         itemCount:
        //             products.length, // Use the length of the products list
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemBuilder: (context, index) {
        //           return SellProductCard(
        //             isDone: index % 2 == 0,
        //             name: products[index].productName,
        //             price: products[index].productPrice.toString(),
        //             image: products[index].productImage,
        //             onView: () {
        //               log('view $index');
        //             },
        //             onEdit: () {
        //               log('edit $index');
        //             },
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
