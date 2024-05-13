import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class MyTicketDetailsContainer extends StatelessWidget {
  const MyTicketDetailsContainer({super.key, this.onCapture, required this.data});

  final void Function()? onCapture;
  final Map<String, dynamic> data;

  Map<String, dynamic> getTicketType() {
    for (Map<String, dynamic> ticket in data['event']['ticketTypes']) {
      if (ticket['_id'] == data['ticketType']) {
        return ticket;
      }
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: dark ? TColors.lightDarkBackground : TColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['event']["eventName"],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: onCapture,
                icon: const Icon(
                  Iconsax.direct_inbox4,
                  color: TColors.primary,
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              Text(
                "Name",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              Text(
                "Reg No.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                UserDataService.getUserName(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                UserDataService.getUserRegID(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              Text(
                "Time",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              Text(
                "Date",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "${DateFormat('hh:mma').format(DateTime.parse(data['event']['eventStartTime']))} - ${DateFormat('hh:mma').format(DateTime.parse(data['event']['eventEndTime']))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                " ${DateFormat('dd MMM yyyy').format(DateTime.parse(data['event']['eventDate']))}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              Text(
                "Location",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              Text(
                "Ticket Type",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                data['event']['eventVenue'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                getTicketType()['ticketTypeName'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
        ],
      ),
    );
  }
}
