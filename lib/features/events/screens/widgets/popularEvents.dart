import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/events/screens/eventDetails.dart';
import 'package:vitkart/features/events/screens/widgets/discount.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PopularEventList extends StatelessWidget {
  const PopularEventList({
    super.key,
    required this.data,
  });

  final List<Map<String, dynamic>> data;

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
            child: PopularEventCard(data: data[index]),
          );
        },
      ),
    );
  }
}

class PopularEventCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const PopularEventCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EventDetailScreen());
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(data['backgroundImage']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DiscountContainer(discount: data['discount']),
                ),
                const Spacer(),
              ],
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
                    venue: data['venue'],
                    clubName: data['clubName'],
                    datetime: data['datetime'],
                    ticketPrice: data['ticketPrice'],
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
              Text(
                eventName,
                style: Theme.of(context).textTheme.titleMedium,
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
                        .titleSmall
                        ?.copyWith(color: TColors.primary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            clubName,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 2,
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
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                venue,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          // Add other content
        ],
      ),
    );
  }
}
