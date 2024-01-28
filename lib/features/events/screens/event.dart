import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/widgets/eventCatGrid.dart';
import 'package:vitkart/features/events/screens/widgets/eventsForYou.dart';
import 'package:vitkart/features/events/screens/widgets/eventsheader.dart';
import 'package:vitkart/features/events/screens/widgets/tEventCategoryCard.dart';
import 'package:vitkart/features/shop/screens/home/home.dart';
import 'package:vitkart/utils/constants/check_mark_indicator.dart';

import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/staticData.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _forceRefresh1 = Object();
  var _forceRefresh2 = Object();
  var _forceRefresh3 = Object();
  var _forceRefresh4 = Object();

  @override
  Widget build(BuildContext context) {
    const dark = false; // Replace with your dark mode logic

    return Scaffold(
      body: CheckMarkIndicator(
        onRefresh: () async {
          setState(() {
            _forceRefresh1 = Object();
            _forceRefresh2 = Object();
            _forceRefresh3 = Object();
            _forceRefresh4 = Object();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TEventsHeader(),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TSectionHeading(
                      title: "Category",
                      key: ValueKey(_forceRefresh1),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TEventCategoryGrid(
                      key: ValueKey(_forceRefresh2),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const TSectionHeading(title: "Popular Events"),
                    EventsHorizontalListFromAPI(
                      key: ValueKey(_forceRefresh3),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const TSectionHeading(title: "Events for you"),
                    EventsHorizontalListFromAPI(
                      key: ValueKey(_forceRefresh4),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
