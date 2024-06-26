import 'dart:developer';
import 'dart:ui';

import 'package:action_slider/action_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailHeader.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailsHeaderText.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/check_mark_indicator.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class EventDetailScreen extends StatefulWidget {
  EventDetailScreen({
    super.key,
    required this.data,
  });

  Map<String, dynamic> data;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
// with WidgetsBindingObserver
{
  List<GlobalKey> keys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];

  EventDetailController eventDetailController =
      Get.put(EventDetailController());

  final _controller = ActionSliderController();

  @override
  void initState() {
    super.initState();
    eventDetailController.data = widget.data;
    eventDetailController.optionsSelection.value = 0;
    eventDetailController.ticektCountUpdate();
  }

  onRefresh(BuildContext context) async {
    Map<String, dynamic> response =
        await APIFunctions.getEvents(id: eventDetailController.data['_id']);
    if (response['isSuccess']) {
      if (response['events'].isEmpty) {
        showErrorToast(context, 'No events found');
        return;
      }
      setState(() {
        eventDetailController.data = response['events'][0];
      });
      return;
    }
    showErrorToast(context, response['message']);
  }

  // @override
  // void didChangeMetrics() {}

  @override
  Widget build(BuildContext context) {
    log("ishere : ${widget.data}");
    final dark = THelperFunctions.isDarkMode(context);
    final double timelineSpace = TSizes.displayWidth(context) / 5.24;
    return Scaffold(
      // extendBody: true, // Set extendBody to true
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              rolling: true,
              width: TSizes.displayWidth(context) * 0.8,
              backgroundColor: TColors.lightDarkBackground,
              toggleColor: TColors.primary,
              iconAlignment: Alignment.centerRight,
              loadingIcon: const SizedBox(
                  width: 55,
                  child: Center(
                      child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white,
                    ),
                  ))),
              successIcon: const SizedBox(
                  width: 55, child: Center(child: Icon(Icons.check_rounded))),
              icon: const SizedBox(
                  width: 55,
                  child: Center(child: Icon(Iconsax.arrow_right_34))),
              action: (controller) async {
                controller.loading(); //starts loading animation
                await Future.delayed(const Duration(seconds: 2));
                //starts success animation

                if (eventDetailController.data['ticketTypes']
                            [eventDetailController.optionsSelection.value]
                        ['availableQuantity'] ==
                    0) {
                  log("No tickets available");
                  showErrorToast(context, "No tickets available");
                } else {
                  log("full tickets available");
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Confirm Booking'),
                      content: const Text(
                          'Are you sure you want to book this event?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: const Text('No',
                              style: TextStyle(color: TColors.primary)),
                          onPressed: () async {
                            await Future.delayed(const Duration(seconds: 1));
                            controller.success();
                            controller.reset();
                            Get.back();
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: TColors.primary),
                          ),
                          onPressed: () async {
                            //starts loading animation
                            DateTime coundDown = DateTime.now();
                            Get.back();
                            await showCupertinoModalPopup(
                              barrierDismissible: false,
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: Text(
                                  'Please Confirm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: TColors.warning,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                message: Text(
                                  'You have only 10 minutes to book the ticket and in case of failure, there will be 10 mins of cooldown to prevent any further payment failure',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    if (DateTime.now()
                                            .difference(coundDown)
                                            .inSeconds <
                                        10) {
                                      return;
                                    }

                                    Get.back();
                                  },
                                  child: Countdown(
                                    seconds: 10,
                                    build: (BuildContext context, double time) {
                                      return Text(
                                        time > 0
                                            ? 'Wait for ${time.toInt()} seconds'
                                            : 'Okay, Got it',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: time > 0
                                                  ? TColors.warning
                                                  : TColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      );
                                    },
                                    interval: const Duration(seconds: 1),
                                  ),
                                ),
                              ),
                            );
                            // return;
                            await eventDetailController.createOrderIdApiHit(
                                context, controller);
                            await Future.delayed(const Duration(seconds: 1));
                            controller.success();
                            controller.reset();
                          },
                        ),
                      ],
                    ),
                  );
                }

                //
                // else{

                // }
              },
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: TSizes.displayWidth(context) * 0.15,
                  ),
                  Text(
                    'Slide to Book Tickets',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              )),
            ),
          ],
        ),

        //  ElevatedButton(
        //       onPressed: () {
        //         // Handle booking action
        //         Get.to(() => const PreviewEventOrderScreen());
        //       },
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: TColors.primary,
        //         padding: const EdgeInsets.all(TSizes.defaultSpace * 1.25),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //       ),
        //       child: const Text(
        //         'Book Now',
        //         style: TextStyle(fontSize: 16),
        //       ),
        //     ),
      ),

      body: CheckMarkIndicator(
        onRefresh: () async {
          await onRefresh(context);
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                TEventHeaderContainer(
                    height: TSizes.displayHeight(context) * 0.36,
                    image: widget.data['eventImages'][0],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                "assets/images/content/back.png",
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ]),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => TEventDetailsHeaderText(
                          ename: widget.data['eventName'],
                          edate: widget.data['eventDate'],
                          estarttime: widget.data['eventStartTime'],
                          eendtime: widget.data['eventEndTime'],
                          evenue: widget.data['eventVenue'],
                          eprice:
                              "${eventDetailController.data['ticketTypes'][eventDetailController.optionsSelection.value]['basePrice']}",
                          eticketsLeft: eventDetailController
                                      .data['ticketTypes']
                                  [eventDetailController.optionsSelection.value]
                              ['availableQuantity'],
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      // const TSectionHeading(
                      //   title: "Timeline",
                      //   showActionButton: false,
                      // ),
                      // Stack(
                      //   children: [
                      //     // AnimatedPositioned(
                      //     //   duration: const Duration(milliseconds: 400),
                      //     //   curve: Curves.easeInOut,
                      //     //   left: previewWidgetX -
                      //     //       (TSizes.displayWidth(context) * 0.048),
                      //     //   top: previewWidgetY -
                      //     //       (TSizes.displayHeight(context) * 0.486),
                      //     //   child: AnimatedContainer(
                      //     //     duration: Duration(milliseconds: 400),
                      //     //     curve: Curves.easeInOut,
                      //     //     width: 36,
                      //     //     height: 36,
                      //     //     decoration: BoxDecoration(
                      //     //       color: TColors.primary,
                      //     //       borderRadius: BorderRadius.circular(100),
                      //     //       border: Border.all(
                      //     //         color: TColors.primary,
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     Column(
                      //       children: [
                      //         const SizedBox(
                      //           height: TSizes.spaceBtwItems,
                      //         ),
                      //         Center(
                      //           child: FixedTimeline(
                      //             theme: TimelineThemeData(
                      //               direction: Axis.horizontal,
                      //             ),
                      //             // direction: Axis.horizontal,
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               InkWell(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 onTap: () {
                      //                   selectedTimeLine = 0;
                      //                   log("X Y : ${getXYfromKey(keys[0])}");
                      //                 },
                      //                 child: OutlinedDotIndicator(
                      //                   key: keys[0],
                      //                   borderWidth: 2,
                      //                   size: 28,
                      //                   child: Icon(
                      //                     Iconsax.tick_circle,
                      //                     size: 18,
                      //                   ),
                      //                   color: TColors.primary,
                      //                   backgroundColor: TColors.primary,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: timelineSpace,
                      //                 child: SolidLineConnector(
                      //                   color: TColors.primary,
                      //                   thickness: 2,
                      //                 ),
                      //               ),
                      //               InkWell(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 onTap: () {
                      //                   selectedTimeLine = 1;
                      //                   log("X Y : ${getXYfromKey(keys[1])}");
                      //                 },
                      //                 child: OutlinedDotIndicator(
                      //                   key: keys[1],
                      //                   borderWidth: 2,
                      //                   size: 28,
                      //                   child: Icon(
                      //                     Iconsax.tick_circle,
                      //                     size: 18,
                      //                   ),
                      //                   color: TColors.primary,
                      //                   backgroundColor: TColors.primary,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: timelineSpace,
                      //                 child: DashedLineConnector(
                      //                   color: TColors.warning,
                      //                   thickness: 2,
                      //                   dash: 8,
                      //                   gap: 4,
                      //                 ),
                      //               ),
                      //               InkWell(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 onTap: () {
                      //                   selectedTimeLine = 2;
                      //                   log("X Y : ${getXYfromKey(keys[2])}");
                      //                 },
                      //                 child: OutlinedDotIndicator(
                      //                   key: keys[2],
                      //                   borderWidth: 2,
                      //                   size: 28,
                      //                   child: Icon(
                      //                     Iconsax.clock,
                      //                     size: 18,
                      //                   ),
                      //                   color: TColors.warning,
                      //                   backgroundColor: TColors.warning,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 width: timelineSpace,
                      //                 child: DashedLineConnector(
                      //                   color: Colors.blue[800],
                      //                   thickness: 2,
                      //                   gap: 4,
                      //                 ),
                      //               ),
                      //               InkWell(
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 onTap: () {
                      //                   selectedTimeLine = 3;
                      //                   log("X Y : ${getXYfromKey(keys[3])}");
                      //                 },
                      //                 child: OutlinedDotIndicator(
                      //                   key: keys[3],
                      //                   borderWidth: 2,
                      //                   size: 28,
                      //                   child: Icon(
                      //                     Icons.circle_outlined,
                      //                     size: 18,
                      //                     color: TColors.white,
                      //                   ),
                      //                   color: Colors.blue[800],
                      //                   backgroundColor: Colors.blue[800],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           height: TSizes.spaceBtwItems,
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),

                      // const SizedBox(
                      //   height: TSizes.spaceBtwItems,
                      // ),

                      Text(
                        "Select Ticket",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.data["ticketTypes"].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2,
                          // Add spacing between items horizontally
                        ),
                        itemBuilder: (context, index) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () {
                                eventDetailController.optionsSelection.value =
                                    index;
                              },
                              child: Center(
                                child: TicketTypeSelectionWidget(
                                  isSeleted: eventDetailController
                                          .optionsSelection.value ==
                                      index,
                                  ticketName: widget.data["ticketTypes"][index]
                                      ["ticketTypeName"],
                                  ticketPrice:
                                      "₹ ${widget.data["ticketTypes"][index]["basePrice"]}",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TSectionHeading(
                            title: "Description",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Text(
                            widget.data['eventDesc'],
                            style: Theme.of(context).textTheme.titleSmall,
                            // maxLines: 4,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSectionHeading(
                        title: "Club Details",
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TRoundedContainer(
                        height: TSizes.displayHeight(context) * 0.17,
                        padding: const EdgeInsets.all(TSizes.md),
                        width: double.infinity,
                        backgroundColor:
                            dark ? TColors.lightDarkBackground : TColors.light,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: widget.data['clubId']['clubLogo'][0],
                                fit: BoxFit.fill,
                                width: TSizes.displayWidth(context) * 0.27,
                                placeholder: (context, url) => Container(
                                  // Add a placeholder widget if needed
                                  color: Colors
                                      .grey, // Placeholder background color
                                ),
                                errorWidget: (context, url, error) => Container(
                                  // Add an error widget if needed
                                  color: Colors.red, // Error background color
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.md,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: TSizes.displayWidth(context) * 0.5,
                                  child: Text(
                                    widget.data['clubId']['clubName']
                                        .toString(),
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  widget.data['clubId']['clubDesc'].toString(),
                                  maxLines: 1,
                                  softWrap: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                SizedBox(
                                  width: TSizes.displayWidth(context) * 0.5,
                                  child: Text(
                                    widget.data['clubId']['clubEmail']
                                        .toString(),
                                    maxLines: 1,
                                    //  softWrap: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                ),
                                Text(
                                  widget.data['clubId']['clubPhone'].toString(),
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class TicketTypeSelectionWidget extends StatelessWidget {
  TicketTypeSelectionWidget({
    super.key,
    required this.isSeleted,
    required this.ticketName,
    required this.ticketPrice,
  });

  String ticketName;
  String ticketPrice;
  bool isSeleted;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        Image.asset(
          "assets/icons/events/Ticket-PNG-HD-Image.png",
          color: dark
              ? (isSeleted ? TColors.primary : TColors.lightDarkBackground)
              : (isSeleted ? TColors.primary : TColors.light),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Row(
          children: [
            SizedBox(
              width: TSizes.displayWidth(context) * 0.14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: Text(
                    ticketName.length > 8
                        ? "${ticketName.substring(0, 8)}..."
                        : ticketName,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  ticketPrice,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: isSeleted ? TColors.white : TColors.primary,
                      ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF121933) // Set the color of the dotted line
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5; // Adjust the dash width
    const double dashSpace = 5; // Adjust the space between dashes

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
