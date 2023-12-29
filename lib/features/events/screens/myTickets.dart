import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/widgets/eventTicketVertical.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class MyTicketScreen extends StatelessWidget {
  const MyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "My Tickets",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TSectionHeading(
                  title: "Upcoming",
                  textColor: TColors.primary,
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                EventTicketVertical(),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                EventTicketVertical(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TSectionHeading(
                  title: "Earlier",
                 
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                EventTicketVertical(),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                EventTicketVertical(),
              ],
            )),
      ),
    );
  }
}
