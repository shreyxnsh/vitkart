
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:vitkart/features/events/screens/event.dart';
import 'package:vitkart/features/personalization/screens/settings/settings.dart';
import 'package:vitkart/features/shop/screens/home/home.dart';
import 'package:vitkart/features/shop/screens/store/sell.dart';
import 'package:vitkart/features/shop/screens/store/store.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatefulWidget {
  final token;
  const NavigationMenu({super.key, this.token});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late String userId;
  late String userName;

  @override
  void initState() {
    super.initState();

    final userToken = GetStorage().read('token');

    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(userToken);

      // getting the user id of the user from db by variable _id from tokenData

      userId = jwtDecodedToken['userID'];
      userName = jwtDecodedToken['userName'];
      // userId = jwtDecodedToken['_id'];
      print("User token in NavigationMenu is : ${widget.token}");
      print("User ID in NavigationMenu is : $userId");
      print("User Name in NavigationMenu is : $userName");
    } else {
      // Handle the case where the token is null
      print("Token is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,

          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (int index) =>
              controller.selectedIndex.value = index,

          //
          backgroundColor: darkMode ? TColors.dark : TColors.light,
          indicatorColor: darkMode ? Colors.transparent : Colors.transparent,

          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: "Home",
              selectedIcon: Icon(
                Iconsax.home5,
                color: TColors.primary,
              ),
            ),
             NavigationDestination(
              icon: Icon(Iconsax.shopping_cart),
              label: "Store",
              selectedIcon: Icon(
                Iconsax.shopping_cart5,
                color: TColors.primary,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.ticket),
              label: "Events",
              selectedIcon: Icon(
                Iconsax.ticket,
                color: TColors.primary,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.add_square),
              label: "Sell",
              selectedIcon: Icon(
                Iconsax.add_square5,
                color: TColors.primary,
              ),
            ),
           
            NavigationDestination(
              icon: Icon(Iconsax.personalcard),
              label: "Account",
              selectedIcon: Icon(
                Iconsax.personalcard5,
                color: TColors.primary,
              ),
            ),
          ],
        ),
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text("Exit"),
                  content: const Text("Are you sure you want to exit"),
                  actions: [
                    CupertinoDialogAction(
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: TColors.primary),
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        }),
                    CupertinoDialogAction(
                        child: const Text(
                          "No",
                          style: TextStyle(color: TColors.primary),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          },
          child: Obx(() => controller.screens[controller.selectedIndex.value])),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const EventScreen(),
    const SellScreen(),
    const SettingScreen(),
  ];
}
