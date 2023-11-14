import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/products/products_cart/cart_menu_item.dart';
import 'package:t_store/common/widgets/products/t_brand_card.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/utils/constants/colors.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

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
                TCartCounterIcon(
                  onPressed: () {},
                  iconColor: dark ? TColors.white : TColors.black,
                )
              ]),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: dark ? TColors.black : TColors.white,
                    expandedHeight: 440,
                    automaticallyImplyLeading: false,

                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          /// search bar
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          const TSearchContainer(
                            text: 'Search in Store',
                            showBorder: true,
                            icon: Iconsax.search_normal,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          /// featured
                          const TSectionHeading(
                            title: 'Featured Brands',
                            showActionButton: true,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),

                          TGridLayout(
                              itemCount: 4,
                              mainAxisExtend: 80,
                              itemBuilder: (_, index) {
                                return TBrandCard(dark: dark);
                              })
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
