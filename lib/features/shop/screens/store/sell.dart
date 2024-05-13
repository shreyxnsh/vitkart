import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/store/create_product.dart';
import 'package:vitkart/features/shop/screens/store/sell_stats.dart';
import 'package:vitkart/features/shop/screens/store/widgets/sellProductCard.dart';
import 'package:vitkart/utils/API/userDataService.dart';
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
  final sellerId = UserDataService.getUserID();

  @override
  void initState() {
    super.initState();
    fetchUserProducts();
  }

  // Future<void> fetchUserProducts() async {
  //   log('$getUserProducts$sellerId');
  //   final response = await http.get(Uri.parse('$getUserProducts$sellerId'));
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     log('Success ');
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     if (data['status']) {
  //       final List<dynamic> productsData = data['products'];
  //       final List<ProductData> fetchedProducts = productsData
  //           .map((product) => ProductData.fromJson(product))
  //           .toList();

  //       setState(() {
  //         products = fetchedProducts;
  //       });
  //     }
  //   } else {
  //     // Handle error
  //     print('Failed to load products');
  //   }
  // }

  Future<Map<String, dynamic>> fetchUserProducts() async {
    log('$getUserProducts$sellerId');

    log("code : $url");
    var headers = {
      'token': UserDataService.getToken(),
      'Content-Type': 'application/json'
    };

    var request = http.Request('GET', Uri.parse(getUserProducts + sellerId));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    log("Produvcts : ${response.statusCode}");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());
      jsonResponse['isSuccess'] = true;
      log("Produvcts :  ${jsonResponse.toString()}");
      log("JSONRESPONSE : ${jsonResponse['products']}");
      final List<dynamic> productsData = jsonResponse['products'];
      final List<ProductData> fetchedProducts =
          productsData.map((product) => ProductData.fromJson(product)).toList();

      setState(() {
        products = fetchedProducts;
      }); // Convert to JSON
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());
      jsonResponse['isSuccess'] = false; // Convert to JSON

      log("Error :  ${jsonResponse.toString()}");
      return jsonResponse;
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
      body: SingleChildScrollView(
        child: Center(
          child:

              //      Padding(
              //   padding: const EdgeInsets.all(TSizes.defaultSpace),
              //   child:

              //   Center(
              //     child: Text(
              //       "Uh Oh! Wait for the V2 launch...  🧑🏻‍💻",
              //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              //             color: TColors.primary,
              //           ),
              //     ),
              //   ),
              // )

              Padding(
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
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSectionHeading(
                  title: 'Your Products',
                  showActionButton: true,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                products.isEmpty
                    ? const Text('No products listed')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: products
                            .length, // Use the length of the products list
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              log('tapped $index');
                              Get.to(SellStatsScreen(product: products[index]));
                            },
                            child: SellProductCard(
                              isDone: index % 2 == 0,
                              name: products[index].productName,
                              price: products[index].productPrice.toString(),
                              image: products[index].productImage[0],
                              status: products[index].productStatus,
                              onView: () {
                                log('view $index');
                              },
                              onEdit: () {
                                log('edit $index');
                              },
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
