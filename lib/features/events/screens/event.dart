import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/appbar/tabbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layout/grid_layout.dart';
import 'package:t_store/common/widgets/products/products_cart/cart_menu_item.dart';
import 'package:t_store/common/widgets/products/t_brand_card.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/events/screens/widgets/eventCatCard.dart';
import 'package:t_store/features/events/screens/widgets/eventCatGrid.dart';
import 'package:t_store/features/events/screens/widgets/eventsForYou.dart';
import 'package:t_store/features/events/screens/widgets/eventsheader.dart';
import 'package:t_store/features/events/screens/widgets/popularEvents.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = false; // Replace with your dark mode logic

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TEventsHeader(),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(title: "Category"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems/2,
                  ),
                  TEventCategoryGrid(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSectionHeading(title: "Popular Events"),
                  PopularEventList(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSectionHeading(title: "Events for you"),
                  EventsForYouList(),





                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
