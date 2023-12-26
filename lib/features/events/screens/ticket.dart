import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/events/screens/widgets/ticketDetails.dart';
import 'package:t_store/features/events/screens/widgets/ticketScanQR.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Tickets",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace , bottom: TSizes.defaultSpace),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: dark ? TColors.lightDarkBackground : TColors.light,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Section with Background Image
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      // height:
                      //     150, // Set the desired height for the background image
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        "assets/images/content/popular1.png",
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    TicketDetailsContainer(),
                    
                    SizedBox(
                      child: Image.asset(
                        "assets/icons/events/horizontaldotted.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    TicketScanQRContainer(),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
