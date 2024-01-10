import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/features/events/screens/widgets/popularEvents.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/utils/API/api_routes.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class EventCategoryScreen extends StatefulWidget {
  const EventCategoryScreen(
      {Key? key, required this.data, required this.categoryName})
      : super(key: key);

  final List<Map<String, dynamic>> data;
  final String categoryName;

  @override
  _EventCategoryScreenState createState() => _EventCategoryScreenState();
}

class _EventCategoryScreenState extends State<EventCategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.data.shuffle();
  }

  // List<ProductData> products = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchTechProducts();
  // }

  // Future<void> fetchTechProducts() async {
  //   final response = await http.get(Uri.parse(techProductsUrl));
  //   print(response);
  //   if (response.statusCode == 200) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('${widget.categoryName} Events',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.data.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 18),
                height: 240,
                width: double.infinity,
                child: PopularEventCard(
                  data: widget.data[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
