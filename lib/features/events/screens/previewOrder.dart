import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/events/screens/ticket.dart';
import 'package:vitkart/features/events/screens/widgets/previewEventCard.dart';
import 'package:vitkart/features/events/screens/widgets/previewPayment.dart';
import 'package:vitkart/features/events/screens/widgets/previewSummary.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class PreviewEventOrderScreen extends StatelessWidget {
  const PreviewEventOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true, // Set extendBody to true
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent, // Set the desired transparent color
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12, // Add a shadow if needed
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ElevatedButton(
              onPressed: () {
                // Handle booking action
                Get.to(() => const TicketScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                padding: const EdgeInsets.all(TSizes.defaultSpace * 1.25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        appBar: TAppBar(
          title: Text('Preview Order', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreviewEventCard(),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                PreviewOrderSummaryCard(),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                PreviewPaymentCard(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ));
  }
}
