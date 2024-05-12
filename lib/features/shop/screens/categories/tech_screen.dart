import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/utils/API/api_routes.dart';
import 'package:vitkart/utils/API/userDataService.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class TechScreen extends StatefulWidget {
  const TechScreen({Key? key}) : super(key: key);

  @override
  _TechScreenState createState() => _TechScreenState();
}

class _TechScreenState extends State<TechScreen> {
  List<ProductData> products = [];

  @override
  void initState() {
    super.initState();
    fetchTechProducts();
  }

  Future<void> fetchTechProducts() async {
    var headers = {
      'Content-Type': 'application/json',
      'token': UserDataService.getToken()
    };
    final response = await http.get(
      Uri.parse(techProductsUrl),
      headers: headers,
    );
    // final response = await http.get(Uri.parse(getAllProductUrl));
    print(response);

    print(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      log("Tech Products: $data");
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
    return Scaffold(
      appBar: TAppBar(
        title: Text('Technology Products',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Other UI elements
              products.isEmpty
              ? Center(
                child: Column(
                  children: [
                    Lottie.asset(
                          'assets/lottie/oops.json',
                          repeat: true,
                          width: TSizes.displayWidth(context) * 0.8,
                          fit: BoxFit.fitWidth,
                          // animate: animateIt,
                        ),
                        // const SizedBox(
                        //   height: TSizes.spaceBtwItems,
                        // ),
                        Text(
                          'No Products Found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                  ],
                ),
              )
              : TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) => TProductCardVertical(
                  product: products[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
