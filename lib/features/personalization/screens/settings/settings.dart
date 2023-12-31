import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/list_tiles/settings_menu.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/events/screens/myTickets.dart';
import 'package:vitkart/features/personalization/screens/address/address.dart';
import 'package:vitkart/features/personalization/screens/profile/profile.dart';
import 'package:vitkart/features/shop/screens/orders/orders.dart';
import 'package:vitkart/utils/API/userDataService.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/user_profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  logOut() {
    bool response = UserDataService.logoutUser();

    if (response) {
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                    showBackArrow: false,
                    title: Text(
                      "Account",
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: TColors.white,
                          ),
                    )),
                // user profile card
                TUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),

            //body
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      right: TSizes.defaultSpace, left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TSectionHeading(title: "Account Settings"),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: "My Orders",
                      subtitle: "In-progress and completed orders",
                      onTap: () {
                        Get.to(() => const OrderScreen());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.ticket,
                      title: "My Tickets",
                      subtitle: "Get All your event tickets here!",
                      onTap: () {
                        Get.to(() => const MyTicketScreen());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: "My Addresses",
                      subtitle: "Set shopping delivery address",
                      onTap: () {
                        Get.to(() => const AddressScreen());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: "My Cart",
                      subtitle: "Add, remove products and move to checkout",
                      onTap: () {},
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.bank,
                      title: "Bank Account",
                      subtitle: "Withdraw balance to registered bank account",
                      onTap: () {},
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.discount_shape,
                      title: "My Coupons",
                      subtitle: "List of all available coupons",
                      onTap: () {},
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subtitle: "All Notifications sent by VITKART",
                      onTap: () {},
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.security_card,
                      title: "Account Privacy",
                      subtitle: "Manage data usage and connected accounts",
                      onTap: () {},
                    ),
                  ],
                ),

                //app settings
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      right: TSizes.defaultSpace, left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      TSectionHeading(title: "App Settings"),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subtitle: "Upload data to cloud firestore",
                      onTap: () {},
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: "Location",
                      subtitle: "Let VITKART access your location",
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: "Safe Mode",
                      subtitle: "Search Result is safe for all ages",
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: "Enhanced Image Quality",
                      subtitle: "Set higher image quality",
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: TSizes.defaultSpace,
                          left: TSizes.defaultSpace),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          child: const Text("Logout"),
                          onPressed: () {
                            logOut();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2.5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
