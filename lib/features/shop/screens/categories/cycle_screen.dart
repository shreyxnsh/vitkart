import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/config/config.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
    List<ProductData> products = [];

  @override
  void initState() {
    super.initState();
    fetchCycleProducts();
  }

  Future<void> fetchCycleProducts() async {
    final response = await http.get(Uri.parse(cycleProductsUrl));
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
            Text('Cycles', style: Theme.of(context).textTheme.headlineMedium),
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

