import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/store/create_product.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Sell Your Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              TSectionHeading(
                title: 'Your Products',
                showActionButton: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
