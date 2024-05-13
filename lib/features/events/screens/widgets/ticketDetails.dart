import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketDetailsContainer extends StatelessWidget {
  TicketDetailsContainer({super.key, this.onCapture});

  EventDetailController eventDetailController = Get.find();
  final void Function()? onCapture;
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
                eventDetailController.data["eventName"],
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
                "${DateFormat('hh:mma').format(eventDetailController.getStartTime())} - ${DateFormat('hh:mma').format(eventDetailController.getEndTime())}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                " ${DateFormat('dd MMM yyyy').format(eventDetailController.getEventDate())}",
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
                eventDetailController.data["eventVenue"],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                eventDetailController.data["ticketTypes"]
                        [eventDetailController.optionsSelection.value]
                    ["ticketTypeName"],
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
