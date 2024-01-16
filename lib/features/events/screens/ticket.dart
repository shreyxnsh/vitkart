import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/features/events/screens/widgets/ticketDetails.dart';
import 'package:vitkart/features/events/screens/widgets/ticketScanQR.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketScreen extends StatefulWidget {
  TicketScreen({super.key, required this.ticketData});

  final Map<String, dynamic> ticketData;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  EventDetailController eventDetailController = Get.find();

  bool showQr = false;
  late QrCode qrCode;

  late QrImage qrImage = QrImage(qrCode);

  late ByteData? imageBytes;

  Future<void> makeQr() async {
    qrCode = QrCode.fromData(
      data: widget.ticketData['Ticket']['_id'],
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
  void initState() {
    super.initState();
    makeQr();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // showQr = false;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Tickets",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          dark ? TColors.lightDarkBackground : TColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Section with Background Image
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          // height:
                          //     150, // Set the desired height for the background image
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              eventDetailController.getBannerImage(),
                              height: TSizes.displayHeight(context) * 0.24,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        TicketDetailsContainer(),

                        SizedBox(
                            child: dark
                                ? Image.asset(
                                    "assets/icons/events/horizontaldotted.png",
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image.asset(
                                    "assets/icons/events/horizontalwhitedot.png",
                                    fit: BoxFit.fitWidth,
                                  )),
                        TicketScanQRContainer(
                          ticketId: widget.ticketData['Ticket']['_id'],
                          onTap: () {
                            setState(() {
                              showQr = !showQr;
                            });
                          },
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showQr = !showQr;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(TSizes.sm),
              margin: const EdgeInsets.all(TSizes.sm),
              width: showQr ? TSizes.displayWidth(context) * 0.8 : 0,
              height: showQr ? TSizes.displayWidth(context) * 0.8 : 0,
              decoration: BoxDecoration(
                boxShadow: showQr
                    ? [
                        BoxShadow(
                          color: TColors.light.withOpacity(0.4),
                          blurRadius: 100,
                          offset: const Offset(0, 0),
                          spreadRadius: 60,
                        )
                      ]
                    : null,
                color: TColors.light,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: TColors.black,
                  width: 8,
                ),
              ),
              child: PrettyQrView(
                qrImage: qrImage,
                decoration: const PrettyQrDecoration(
                  image: PrettyQrDecorationImage(
                    scale: 0.3,
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
    );
  }
}
