import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:vitkart/common/widgets/custom_shapes/containers/t_rounded_containers.dart';
import 'package:vitkart/common/widgets/images/t_circular.image.dart';
import 'package:vitkart/common/widgets/text/product_price_text.dart';
import 'package:vitkart/common/widgets/text/section_heading.dart';
import 'package:vitkart/features/events/screens/previewOrder.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailHeader.dart';
import 'package:vitkart/features/events/screens/widgets/eventDetailsHeaderText.dart';
import 'package:vitkart/features/events/screens/widgets/eventPriceCard.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
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
  int? selectedTicket;

  List<GlobalKey> keys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];

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

  int selectedTimeLine = 0;

  double previewWidgetX = 0.0;
  double previewWidgetY = 0.0;

  ScrollController _scrollController = ScrollController();

  List<double> getXYfromKey(GlobalKey key) {
    log('X Y : --${key.currentContext!.findRenderObject() as RenderBox}');
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    previewWidgetY = position.dy;
    previewWidgetX = position.dx;
    setState(() {});

    return [previewWidgetX, previewWidgetY];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        print('scrolling');
        // getXYfromKey(keys[selectedTimeLine]);
      });
      _scrollController.position.isScrollingNotifier.addListener(() {
        if (!_scrollController.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          // getXYfromKey(keys[selectedTimeLine]);
        } else {
          print('scroll is started');
        }
      });
    });
    super.initState();
  }

  // @override
  // void didChangeMetrics() {}

  @override
  Widget build(BuildContext context) {
    log("ishere : ${widget.data}");
    final dark = THelperFunctions.isDarkMode(context);
    final double timelineSpace = TSizes.displayWidth(context) / 5.24;
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
      body: Stack(
        children: [
          SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  TEventHeaderContainer(
                      height: TSizes.displayHeight(context) * 0.36,
                      image: widget.data['eventImages'][1],
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
                        TEventDetailsHeaderText(
                          ename: widget.data['eventName'],
                          edate: widget.data['eventDate'],
                          etime: widget.data['eventTime'],
                          evenue: widget.data['eventVenue'],
                          eprice: widget.data['ticketPrice'] ?? "0",
                          eticketsLeft: widget.data['ticketsLeft'] ?? 0,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const TSectionHeading(
                          title: "Timeline",
                          showActionButton: false,
                        ),
                        Stack(
                          children: [
                            // AnimatedPositioned(
                            //   duration: const Duration(milliseconds: 400),
                            //   curve: Curves.easeInOut,
                            //   left: previewWidgetX -
                            //       (TSizes.displayWidth(context) * 0.048),
                            //   top: previewWidgetY -
                            //       (TSizes.displayHeight(context) * 0.486),
                            //   child: AnimatedContainer(
                            //     duration: Duration(milliseconds: 400),
                            //     curve: Curves.easeInOut,
                            //     width: 36,
                            //     height: 36,
                            //     decoration: BoxDecoration(
                            //       color: TColors.primary,
                            //       borderRadius: BorderRadius.circular(100),
                            //       border: Border.all(
                            //         color: TColors.primary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                                Center(
                                  child: FixedTimeline(
                                    theme: TimelineThemeData(
                                      direction: Axis.horizontal,
                                    ),
                                    // direction: Axis.horizontal,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          selectedTimeLine = 0;
                                          log("X Y : ${getXYfromKey(keys[0])}");
                                        },
                                        child: OutlinedDotIndicator(
                                          key: keys[0],
                                          borderWidth: 2,
                                          size: 28,
                                          child: Icon(
                                            Iconsax.tick_circle,
                                            size: 18,
                                          ),
                                          color: TColors.primary,
                                          backgroundColor: TColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: timelineSpace,
                                        child: SolidLineConnector(
                                          color: TColors.primary,
                                          thickness: 2,
                                        ),
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          selectedTimeLine = 1;
                                          log("X Y : ${getXYfromKey(keys[1])}");
                                        },
                                        child: OutlinedDotIndicator(
                                          key: keys[1],
                                          borderWidth: 2,
                                          size: 28,
                                          child: Icon(
                                            Iconsax.tick_circle,
                                            size: 18,
                                          ),
                                          color: TColors.primary,
                                          backgroundColor: TColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: timelineSpace,
                                        child: DashedLineConnector(
                                          color: TColors.warning,
                                          thickness: 2,
                                          dash: 8,
                                          gap: 4,
                                        ),
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          selectedTimeLine = 2;
                                          log("X Y : ${getXYfromKey(keys[2])}");
                                        },
                                        child: OutlinedDotIndicator(
                                          key: keys[2],
                                          borderWidth: 2,
                                          size: 28,
                                          child: Icon(
                                            Iconsax.clock,
                                            size: 18,
                                          ),
                                          color: TColors.warning,
                                          backgroundColor: TColors.warning,
                                        ),
                                      ),
                                      SizedBox(
                                        width: timelineSpace,
                                        child: DashedLineConnector(
                                          color: Colors.blue[800],
                                          thickness: 2,
                                          gap: 4,
                                        ),
                                      ),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () {
                                          selectedTimeLine = 3;
                                          log("X Y : ${getXYfromKey(keys[3])}");
                                        },
                                        child: OutlinedDotIndicator(
                                          key: keys[3],
                                          borderWidth: 2,
                                          size: 28,
                                          child: Icon(
                                            Icons.circle_outlined,
                                            size: 18,
                                            color: TColors.white,
                                          ),
                                          color: Colors.blue[800],
                                          backgroundColor: Colors.blue[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
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
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
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
                          height: TSizes.displayHeight(context) * 0.16,
                          padding: const EdgeInsets.all(TSizes.md),
                          width: double.infinity,
                          backgroundColor: dark
                              ? TColors.lightDarkBackground
                              : TColors.light,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  widget.data['eventImages'][0],
                                  fit: BoxFit.fill,
                                  width: TSizes.displayWidth(context) * 0.27,
                                ),
                              ),
                              const SizedBox(
                                width: TSizes.md,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data['eventOrg'],
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    widget.data['clubPerson'],
                                    maxLines: 1,
                                    softWrap: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                  Text(
                                    widget.data['clubEmail'] != null &&
                                            widget.data['clubEmail'].length > 27
                                        ? '${widget.data['clubEmail']!.substring(0, 27)}...'
                                        : widget.data['clubEmail'] ?? '',
                                    // maxLines: 2,
                                    //  softWrap: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          overflow: TextOverflow.fade,
                                        ),
                                  ),
                                  Text(
                                    widget.data['clubPhone'],
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
        ],
      ),
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
