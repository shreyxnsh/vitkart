import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/features/events/screens/eventDetails.dart';
import 'package:vitkart/features/events/screens/widgets/discount.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PopularEventList extends StatelessWidget {
  const PopularEventList({
    super.key,
    required this.data,
  });

  final List data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: TEventCategoryCard(data: data[index]),
          );
        },
      ),
    );
  }
}

class TEventCategoryCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const TEventCategoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    log("data-- :${data.toString()}");
    return GestureDetector(
      onTap: () {
        Get.to(
          () => EventDetailScreen(
            data: data,
          ),
        );
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            // Replace the NetworkImage with clubLogo
            image: CachedNetworkImageProvider(data['eventImages'][0]),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: data['discount'] != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DiscountContainer(discount: data['discount'] ?? ""),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ClipRect(
                  child: EventDetailsContainer(
                    eventName: data['eventName'],
                    venue: data['eventVenue'],
                    clubName: data['clubId']['clubName'],
                    datetime:
                        "${DateFormat("dd MMM yyyy").format(DateTime.parse(data['eventDate']))} ${DateFormat("hh:mm a").format(DateTime.parse(data['eventStartTime']))}",
                    ticketPrice:
                        data['ticketTypes'][0]['basePrice'].toString() ?? "100",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetailsContainer extends StatelessWidget {
  final String eventName;
  final String clubName;
  final String datetime;
  final String venue;
  final String ticketPrice;

  const EventDetailsContainer({
    super.key,
    required this.eventName,
    required this.datetime,
    required this.venue,
    required this.ticketPrice,
    required this.clubName,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: dark ? TColors.lightDarkBackground : TColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: TColors.lightDarkBackground,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: TSizes.displayWidth(context) * 0.4,
                child: Text(
                  eventName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  //     Image.asset(
                  //   'assets/images/star.png',
                  //   width: 15, // Double the width
                  //   height: 15, // Double the height
                  // ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "₹ $ticketPrice",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: TColors.primary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 0,
          ),
          Text(
            clubName,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              // Image.asset(
              //   locationIcon,
              //   width: 20,
              //   height: 20,
              //   // Adjust the image path and size as needed
              // ),

              Text(
                datetime,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: TColors.white,
                    ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: TSizes.displayWidth(context) * 0.17,
                child: Text(
                  venue,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: TColors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ],
          ),
          // Add other content
        ],
      ),
    );
  }
}
