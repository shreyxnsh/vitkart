import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/previewOrder.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailHeader.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailsHeaderText.dart';
import 'package:vitkart/features/events/screens/widgets/eventPriceCard.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int? selectedTicket;

  // Event Timeline
  List<Map<String, dynamic>> timeLine = [
    {
      "title": "Event Starts",
      "startTime":
          DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 9:00:00"),
      "endTime": DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 11:59:00"),
    },
    {
      "title": "Lunch Break",
      "startTime":
          DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 12:00:00"),
      "endTime": DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 12:29:00"),
    },
    {
      "title": "Result Announced",
      "startTime":
          DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 12:30:00"),
      "endTime": DateFormat("yyyy-MM-dd HH:mm:ss").parse("2023-01-01 12:59:00"),
    },
  ];

  int selectedTimeLine = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Set extendBody to true
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent, // Set the desired transparent color
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12, // Add a shadow if needed
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () {
              // Handle booking action
              Get.to(() => const PreviewEventOrderScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              padding: const EdgeInsets.all(TSizes.defaultSpace * 1.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          TEventHeaderContainer(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            padding: const EdgeInsets.only(
                left: TSizes.defaultSpace, right: TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TEventDetailsHeaderText(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Column(
                  children: [
                    const TSectionHeading(
                      title: "Description",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Text(
                      TTexts.eventDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Column(
                  children: [
                    const TSectionHeading(
                      title: "TimeLine",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Column(
                      children: [
                        Text(
                          // total time in hours
                          "Total Event Time : ${(timeLine.last["endTime"].difference(timeLine.first["startTime"]).inMinutes / 60).toStringAsFixed(2)} Hours",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          ...timeLine.map((event) {
                            return GestureDetector(
                              onTap: () {
                                if (selectedTimeLine ==
                                    timeLine.indexOf(event)) {
                                  setState(() {
                                    selectedTimeLine = -1;
                                  });
                                  return;
                                }
                                setState(() {
                                  selectedTimeLine = timeLine.indexOf(event);
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(2),
                                width: (TSizes.displayWidth(context) /
                                        timeLine.length) -
                                    TSizes.spaceBtwSections,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: selectedTimeLine ==
                                          timeLine.indexOf(event)
                                      ? TColors.primary
                                      : TColors.lightDarkBackground,
                                ),
                              ),
                            );
                          })
                        ]),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                    ...timeLine.map((event) {
                      return GestureDetector(
                        onTap: () {
                          if (selectedTimeLine == timeLine.indexOf(event)) {
                            setState(() {
                              selectedTimeLine = -1;
                            });
                            return;
                          }
                          setState(() {
                            selectedTimeLine = timeLine.indexOf(event);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          margin: const EdgeInsets.all(TSizes.xs),
                          decoration: BoxDecoration(
                            color: selectedTimeLine == timeLine.indexOf(event)
                                ? TColors.primary
                                : TColors.lightDarkBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.defaultSpace),
                            child: Row(
                              children: [
                                Text(
                                  event["title"],
                                ),
                                const Spacer(),
                                Text(
                                  "${DateFormat("h:mm a").format(event["startTime"])} - ${DateFormat("h:mm a").format(event["endTime"])}",
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const TSectionHeading(
                      title: "Tickets",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TEventPriceCard(
                      isScelected:
                          selectedTicket != null ? selectedTicket == 0 : false,
                      image: TImages.earlyBirdTicket,
                      type: "Early Bird",
                      desc: "Only for 100 Tickets",
                      price: "₹ 100",
                      onTap: () {
                        // Handle the selection/deselection logic here

                        setState(() {
                          if (selectedTicket == 0) {
                            selectedTicket = null;

                            return;
                          }
                          selectedTicket = 0;
                        });
                      },
                    ),
                    const SizedBox(
                      height: TSizes.xs,
                    ),
                    TEventPriceCard(
                      isScelected:
                          selectedTicket != null ? selectedTicket == 1 : false,
                      image: TImages.normalTicket,
                      type: "Normal",
                      desc: "Only for next 200 Tickets",
                      price: "₹ 200",
                      onTap: () {
                        // Handle the selection/deselection logic here
                        setState(() {
                          if (selectedTicket == 1) {
                            selectedTicket = null;

                            return;
                          }
                          selectedTicket = 1;
                        });
                      },
                    ),
                    const SizedBox(
                      height: TSizes.xs,
                    ),
                    TEventPriceCard(
                      isScelected:
                          selectedTicket != null ? selectedTicket == 2 : false,
                      image: TImages.lastMomentTicket,
                      type: "Last Moment",
                      desc: "On-Spot Registrations",
                      price: "₹ 300",
                      onTap: () {
                        // Handle the selection/deselection logic here
                        setState(() {
                          if (selectedTicket == 2) {
                            selectedTicket = null;

                            return;
                          }
                          selectedTicket = 2;
                        });
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  ],
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
