import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vitkart/features/events/screens/myTicketDetailScreen.dart';
import 'package:vitkart/features/events/screens/myTickets.dart';
import 'package:vitkart/features/events/screens/ticket.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class EventTicketVertical extends StatefulWidget {
  final Map<String, dynamic> data;

  const EventTicketVertical({super.key, required this.data});

  @override
  State<EventTicketVertical> createState() => _EventTicketVerticalState();
}

class _EventTicketVerticalState extends State<EventTicketVertical> {
  late QrCode qrCode;

  late QrImage qrImage = QrImage(qrCode);

  late ByteData? imageBytes;

  @override
  void initState() {
    super.initState();
    makeQr();
  }

  Future<void> makeQr() async {
    qrCode = QrCode.fromData(
      data: widget.data['_id'],
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    qrImage = QrImage(qrCode);
    imageBytes = await qrImage.toImageAsBytes(
      size: 512,
      format: ImageByteFormat.png,
      decoration: const PrettyQrDecoration(),
    );
  }

  @override
  Widget build(BuildContext context) {
    log("Data : ${widget.data}");
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        Get.to(() =>  TicketDetailScreen(ticketData: widget.data,));
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: dark ? TColors.lightDarkBackground : TColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x21000000),
              blurRadius: 49,
              offset: Offset(-13, 21),
              spreadRadius: -31,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Content
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data['event']['eventOrg'].toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.data['event']['eventName'].toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(

                              DateFormat('dd MMM yyyy').format(DateTime.parse(widget.data['event']['eventDate'])),
                               
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Text(
                          widget.data['event']['eventVenue'].toString(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                // Oval Borders and Dotted Line

                // Right Content
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   child: Image.asset(
                    //     "assets/icons/events/verticaldotted.png",
                    //     color: dark ? TColors.darkBackground : TColors.light,
                    //     height: 115,
                    //     fit: BoxFit.fitHeight,
                    //   ),
                    // ),
                     Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: TColors.white,
                            ),
                            width: TSizes.displayWidth(context) * 0.22,
                            height: TSizes.displayWidth(context) * 0.22,
                            child: PrettyQrView(
                              qrImage: qrImage,
                              decoration: const PrettyQrDecoration(
                                image: PrettyQrDecorationImage(
                                  scale: 0.4,
                                  image: AssetImage(
                                    "assets/icons/vitkart/vitkart_logogreen.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                     ),
                      
                    
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF121933)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5.0;
    const double dashSpace = 5.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
