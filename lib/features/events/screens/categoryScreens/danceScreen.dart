
import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class DanceScreen extends StatefulWidget {
  const DanceScreen({Key? key}) : super(key: key);

  @override
  _DanceScreenState createState() => _DanceScreenState();
}

class _DanceScreenState extends State<DanceScreen> {
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
        title: Text('Dance Events',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Other UI elements

              // TGridLayout(
              //   itemCount: products.length,
              //   itemBuilder: (_, index) => TProductCardVertical(
              //     product: products[index],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
