import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class PreviewEventCard extends StatelessWidget {
  PreviewEventCard({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  EventDetailController eventDetailController = Get.find();

  @override
  Widget build(BuildContext context) {
    log("preview :${data.toString()}");

    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: dark ? TColors.lightDarkBackground : TColors.light,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section with Background Image
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: data['eventImages'][0],
                fit: BoxFit.fill,
                width: double.infinity,
                height: TSizes.displayHeight(context) * 0.22,
                placeholder: (context, url) => Container(
                  // Add a placeholder widget if needed
                  color: Colors.grey, // Placeholder background color
                ),
                errorWidget: (context, url, error) => Container(
                  // Add an error widget if needed
                  color: Colors.red, // Error background color
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),

          // Bottom Section with Event Details
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: dark ? TColors.lightDarkBackground : TColors.light,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: Border.all(
                color: dark ? TColors.lightDarkBackground : TColors.light,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      data['eventName'],
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  "VIT Bhopal",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.calendar5,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          " ${DateFormat('dd MMM yyyy').format(DateTime.parse(data['eventDate']))}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Row(
                      children: [
                        Icon(Iconsax.location5,
                            color: Theme.of(context).primaryColor),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          " ${data['eventVenue']}",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      "Ticket Type",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateFormat('hh:mm a').format(DateTime.parse(data['eventStartTime']))} - ${DateFormat('hh:mm a').format(DateTime.parse(data['eventEndTime']))}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      data['ticketTypes']
                              [eventDetailController.optionsSelection.value]
                          ['ticketTypeName'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
