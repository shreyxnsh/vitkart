import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/API/api_routes.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class MattressScreen extends StatefulWidget {
  const MattressScreen({super.key});

  @override
  State<MattressScreen> createState() => _MattressScreenState();
}

class _MattressScreenState extends State<MattressScreen> {
    List<ProductData> products = [];

  @override
  void initState() {
    super.initState();
    fetchMattressProducts();
  }

  Future<void> fetchMattressProducts() async {
    final response = await http.get(Uri.parse(mattressProductsUrl));
    print(response);
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
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Mattreses', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Other UI elements

              TGridLayout(
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

