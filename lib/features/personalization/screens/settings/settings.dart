import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/list_tiles/settings_menu.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/features/authentication/screens/login/widget/LoginPageSignInButton.dart';
import 'package:vitkart/features/authentication/screens/login/widget/loginTextField.dart';
import 'package:vitkart/features/events/screens/myTickets.dart';
import 'package:vitkart/features/personalization/screens/address/address.dart';
import 'package:vitkart/features/personalization/screens/profile/profile.dart';
import 'package:vitkart/features/personalization/screens/settings/notifications.dart';
import 'package:vitkart/features/personalization/screens/settings/terms.dart';
import 'package:vitkart/features/shop/screens/orders/orders.dart';
import 'package:vitkart/utils/API/api_routes.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/staticData.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

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
                TUserProfileTile(),
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
                      TSectionHeading(
                        title: "Account Settings",
                        showActionButton: false,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    TSettingsMenuTile(
                      icon: Iconsax.profile_2user,
                      title: "My Profile",
                      subtitle: "View your Profile and edit details.",
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                    ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.bag_tick,
                    //   title: "My Orders",
                    //   subtitle: "In-progress and completed orders",
                    //   onTap: () {
                    //     Get.to(() => const OrderScreen());
                    //   },
                    // ),

                    
                    
                    TSettingsMenuTile(
                      icon: Iconsax.shopping_bag,
                      title: "My Orders",
                      subtitle: "Get All your orders!",
                      onTap: () {
                        Get.to(() => const OrderScreen());
                      },
                    ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.shopping_bag,
                    //   title: "My Products",
                    //   subtitle: "Get All your orders!",
                    //   onTap: () {
                    //     Get.to(() => const ());
                    //   },
                    // ),
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

                    // TSettingsMenuTile(
                    //   icon: Iconsax.discount_shape,
                    //   title: "My Coupons",
                    //   subtitle: "List of all available coupons",
                    //   onTap: () {},
                    // ),
                    TSettingsMenuTile(
                      icon: Iconsax.notification,
                      title: "Notifications",
                      subtitle: "All Notifications sent by VITKART",
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                    ),
                    TSettingsMenuTile(
                      icon: Iconsax.document,
                      title: "Terms & Conditions",
                      subtitle: "View all terms and conditions by VITKART 2024",
                      onTap: () {
                        Get.to(() => const TermsAndConditionScreen());
                      },
                    ),
                  ],
                ),

                //app settings
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(
                //       right: TSizes.defaultSpace, left: TSizes.defaultSpace),
                //   child: Column(
                //     children: [
                //       TSectionHeading(title: "App Settings"),
                //       SizedBox(
                //         height: TSizes.spaceBtwItems,
                //       ),
                //     ],
                //   ),
                // ),
                Column(
                  children: [
                    // TSettingsMenuTile(
                    //   icon: Iconsax.document_upload,
                    //   title: "Load Data",
                    //   subtitle: "Upload data to cloud firestore",
                    //   onTap: () {},
                    // ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.location,
                    //   title: "Location",
                    //   subtitle: "Let VITKART access your location",
                    //   trailing: Switch(
                    //     value: true,
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.security_user,
                    //   title: "Safe Mode",
                    //   subtitle: "Search Result is safe for all ages",
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // TSettingsMenuTile(
                    //   icon: Iconsax.image,
                    //   title: "Enhanced Image Quality",
                    //   subtitle: "Set higher image quality",
                    //   trailing: Switch(
                    //     value: false,
                    //     onChanged: (value) {},
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: TSizes.spaceBtwSections,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: TSizes.defaultSpace,
                          left: TSizes.defaultSpace),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text(
                            "Logout",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: TColors.white),
                          ),
                          onPressed: () {
                            logOut();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 24.0, horizontal: 16.0),
                    //   child: LoginScreenTextFeild(
                    //     controller: TextEditingController(
                    //       text: Domain.domain,
                    //     ),
                    //     prefixIcon: Iconsax.global,
                    //     labelText: "Domain",
                    //     onChanged: (value) {
                    //       Domain.domain = value;
                    //     },
                    //     onFieldSubmitted: (value) {
                    //       FocusScope.of(context).unfocus();
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2.5,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Developed with ❤️ (App Version : v1.0.0)",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.normal),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              String url =
                                  "https://www.linkedin.com/in/yaviral17/";
                              var urllaunchable = await canLaunchUrl(Uri.parse(
                                  url)); //canLaunch is from url_launcher package
                              if (urllaunchable) {
                                await launchUrl(Uri.parse(
                                    url)); //launch is from url_launcher package to launch URL
                              } else {
                                print("URL can't be launched.");
                              }
                            },
                            child: Text(
                              "@yaviral17  |",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.primary),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String url =
                                  "https://www.linkedin.com/in/shreyxnsh/";
                              var urllaunchable = await canLaunchUrl(Uri.parse(
                                  url)); //canLaunch is from url_launcher package
                              if (urllaunchable) {
                                await launchUrl(Uri.parse(
                                    url)); //launch is from url_launcher package to launch URL
                              } else {
                                print("URL can't be launched.");
                              }
                            },
                            child: Text(
                              "  @shreyxnsh  |",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.primary),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String url =
                                  "https://www.linkedin.com/in/anand-lahoti/";
                              var urllaunchable = await canLaunchUrl(Uri.parse(
                                  url)); //canLaunch is from url_launcher package
                              if (urllaunchable) {
                                await launchUrl(Uri.parse(
                                    url)); //launch is from url_launcher package to launch URL
                              } else {
                                print("URL can't be launched.");
                              }
                            },
                            child: Text(
                              "   @foundanand ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: TColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
