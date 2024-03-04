import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/appbar/tabbar.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:vitkart/common/widgets/layout/grid_layout.dart';
import 'package:vitkart/common/widgets/products/products_cart/cart_menu_item.dart';
import 'package:vitkart/common/widgets/products/t_brand_card.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/shop/screens/store/widgets/category_tab.dart';
import 'package:vitkart/utils/constants/colors.dart';

import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';






final List<Map<String, dynamic>> snackList = [
  {
    'name': "Chips",
    'quantity': 12,
    'icon': 'assets/images/products/chips.png',
  },
  {
    'name': "Biscuits",
    'quantity': 52,
    'icon': 'assets/images/products/biscuit.png',
  },
  {
    'name': "Soft Drinks",
    'quantity': 89,
    'icon': 'assets/images/products/softdrink.png',
  },
  {
    'name': "Namkeen",
    'quantity': 12,
    'icon': 'assets/images/products/namkeen.png',
  },

  // Add more product data as needed
];

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
        length: 6,
        child: Scaffold(
            appBar: TAppBar(
                title: Text('Store',
                    style: Theme.of(context).textTheme.headlineMedium),
                showBackArrow: false,
                actions: [
                  // TCartCounterIcon(
                  //   onPressed: () {

                  //   },
                  //   iconColor: dark ? TColors.white : TColors.black,
                  // )
                ]),
            body: 
            
            // Padding(
            //   padding: const EdgeInsets.all(TSizes.defaultSpace),
            //   child: Center(
            //     child: Text(
            //       "Hang on, we're still coding this screen  🧑🏻‍💻",
            //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            //             color: TColors.primary,
            //           ),
            //     ),
            //   ),
            // )

            NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      backgroundColor:
                          dark ? TColors.darkBackground : TColors.white,
                      expandedHeight: 410,
                      automaticallyImplyLeading: false,

                      flexibleSpace: Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            /// search bar

                            const TSearchContainer(
                              text: 'Search in Store',
                              showBorder: true,
                              icon: Iconsax.search_normal,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),

                            /// featured
                            const TSectionHeading(
                              title: 'Snacks',
                              showActionButton: true,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwItems / 1.5,
                            ),

                            TGridLayout(
                                // itemCount: 4,

                                // itemBuilder: (_, index) {
                                //   return TBrandCard(
                                //     dark: dark
                                //     name: ,
                                //     );
                                // })
                                mainAxisExtend: 80,
                                itemCount: snackList.length,
                                itemBuilder: (_, index) => TBrandCard(
                                      dark: dark,
                                      snacksData: snackList[index],
                                    )),
                          ],
                        ),
                      ),

                      /// Category Tabs
                      bottom: const TTabBar(
                        tabs: [
                          Tab(child: Text('Tech')),
                          Tab(child: Text('Cycles')),
                          Tab(child: Text('Mattresses')),
                          Tab(child: Text('Books')),
                          Tab(child: Text('Buckets')),
                          Tab(child: Text('Others')),
                        ],
                      ),
                    )
                  ];
                },
                body: const TabBarView(
                  children: [
                    TCategoryTab(),
                    TCategoryTab(),
                    TCategoryTab(),
                    TCategoryTab(),
                    TCategoryTab(),
                    TCategoryTab(),
                  ],
                ))),
            );
  }
}
