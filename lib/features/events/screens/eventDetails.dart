import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/features/events/screens/previewOrder.dart';
import 'package:t_store/features/events/screens/widgets/eventDetailHeader.dart';
import 'package:t_store/features/events/screens/widgets/eventDetailsHeaderText.dart';
import 'package:t_store/features/events/screens/widgets/eventPriceCard.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

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
                      title: "Tickets",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TEventPriceCard(
                      image: TImages.earlyBirdTicket,
                      type: "Early Bird",
                      desc: "Only for 100 Tickets",
                      price: "₹ 100",
                      onTap: () {
                        // Handle the selection/deselection logic here
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TEventPriceCard(
                      image: TImages.normalTicket,
                      type: "Normal",
                      desc: "Only for next 200 Tickets",
                      price: "₹ 200",
                      onTap: () {
                        // Handle the selection/deselection logic here
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TEventPriceCard(
                      image: TImages.lastMomentTicket,
                      type: "Last Moment",
                      desc: "On-Spot Registrations",
                      price: "₹ 300",
                      onTap: () {
                        // Handle the selection/deselection logic here
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
