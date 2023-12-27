import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/widgets/eventCatGrid.dart';
import 'package:vitkart/features/events/screens/widgets/eventsForYou.dart';
import 'package:vitkart/features/events/screens/widgets/eventsheader.dart';
import 'package:vitkart/features/events/screens/widgets/popularEvents.dart';

import 'package:vitkart/utils/constants/sizes.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const dark = false; // Replace with your dark mode logic

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TEventsHeader(),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TSectionHeading(title: "Category"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems/2,
                  ),
                  const TEventCategoryGrid(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSectionHeading(title: "Popular Events"),
                  PopularEventList(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSectionHeading(title: "Events for you"),
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
