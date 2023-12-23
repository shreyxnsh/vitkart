import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/events/screens/event.dart';
import 'package:t_store/features/personalization/screens/settings/settings.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/features/shop/screens/store/store.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
          indicatorColor: darkMode
              ? Colors.transparent
              : Colors.transparent,

          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home" , selectedIcon: Icon(Iconsax.home5, color: TColors.primary,),),
            NavigationDestination(icon: Icon(Iconsax.shopping_cart), label: "Store" ,   selectedIcon: Icon(Iconsax.shopping_cart5, color: TColors.primary,),),
            NavigationDestination(icon: Icon(Iconsax.add_square), label: "Sell" , selectedIcon: Icon(Iconsax.add_square5, color: TColors.primary,),),
            NavigationDestination(icon: Icon(Iconsax.ticket), label: "Events" , selectedIcon: Icon(Iconsax.ticket, color: TColors.primary,),),
            NavigationDestination(icon: Icon(Iconsax.personalcard), label: "Account" , selectedIcon: Icon(Iconsax.personalcard5, color: TColors.primary,),),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    Container(color: Colors.red),
    const EventScreen(),
    const SettingScreen(),
  ];
}
