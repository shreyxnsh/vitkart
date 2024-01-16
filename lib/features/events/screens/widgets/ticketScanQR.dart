import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/image_strings.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketScanQRContainer extends StatefulWidget {
  const TicketScanQRContainer({super.key, required this.ticketId, this.onTap});

  final String ticketId;
  final void Function()? onTap;
  @override
  State<TicketScanQRContainer> createState() => _TicketScanQRContainerState();
}

class _TicketScanQRContainerState extends State<TicketScanQRContainer> {
  late QrCode qrCode;

  late QrImage qrImage = QrImage(qrCode);

  late ByteData? imageBytes;

  Future<void> makeQr() async {
    qrCode = QrCode.fromData(
      data: widget.ticketId,
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
    // makeQr();
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: dark ? TColors.darkBackground : TColors.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: TSizes.displayHeight(context) * 0.2,
                    child: Row(children: [
                      Text(
                        TTexts.scanqr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: TSizes.displayHeight(context) * 0.24,
                    child: Row(
                      children: [
                        Text(
                          "Ticket ID : ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        // const Spacer(),
                        SizedBox(
                          width: TSizes.displayWidth(context) * 0.18,
                          child: Text(
                            widget.ticketId,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                        ),
                        // icon to copy to clipboard
                        IconButton(
                          onPressed: () {
                            THelperFunctions.copyToClipBoard(
                                widget.ticketId, context);
                          },
                          icon: const Icon(
                            Iconsax.copy,
                            color: TColors.primary,
                            size: TSizes.lg - 8,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(TSizes.xs),
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                width: TSizes.displayWidth(context) * 0.24,
                height: TSizes.displayWidth(context) * 0.24,
                child: Expanded(
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: PrettyQrView(
                      qrImage: qrImage,
                      decoration: const PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                          image: AssetImage(
                            "assets/icons/vitkart/vitkart_logogreen.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
