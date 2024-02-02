import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/events/screens/widgets/MyTicketDetails.dart';
import 'package:vitkart/features/events/screens/widgets/ticketDetails.dart';
import 'package:vitkart/features/events/screens/widgets/ticketScanQR.dart';
import 'package:vitkart/features/shop/screens/home/home.dart';
import 'package:vitkart/navigation_menu.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TicketDetailScreen extends StatefulWidget {
  TicketDetailScreen({super.key, required this.ticketData});

  final Map<String, dynamic> ticketData;

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  GlobalKey qrKey = GlobalKey();

  bool showQr = false;
  late QrCode qrCode;

  late QrImage qrImage = QrImage(qrCode);

  late ByteData? imageBytes;

  // static Future saveInStorage(
  //     String fileName, File file, String extension) async {

  //   String _localPath = (await ExtStorage.getExternalStoragePublicDirectory(
  //       ExtStorage.DIRECTORY_DOWNLOADS))!;
  //   String filePath =
  //       _localPath + "/" + fileName.trim() + "_" + Uuid().v4() + extension;

  //   File fileDef = File(filePath);
  //   await fileDef.create(recursive: true);
  //   Uint8List bytes = await file.readAsBytes();
  //   await fileDef.writeAsBytes(bytes);
  // }

  Future<String> _getFilePath(String fileName) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    print("Device Version: ${androidInfo.version.sdkInt}");

    if (Platform.isAndroid && androidInfo.version.sdkInt! >= 29) {
      final dir = await getExternalStorageDirectory();
      print("File Name: ${dir!.path}/$fileName");
      return "${dir.path}/$fileName";
    } else {
      var dir = Directory('/storage/emulated/0/Download/AppName');
      print("File Name: ${dir.path}/$fileName");
      return "${dir.path}/$fileName";
    }
  }

  Future<void> saveWidgetImageIntoGallery(BuildContext context) async {
    log("Saving image into gallery");
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      log("Permission granted");
    } else {
      log("Permission not granted");
    }
    try {
      log("in try");
      final RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.6);
      ByteData? byte = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? imageDate = byte!.buffer.asUint8List();
      // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      final result =
          await ImageGallerySaver.saveImage(imageDate.buffer.asUint8List());
      showSuccessToast(context, "Ticket Saved in Gallery :)");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> makeQr() async {
    qrCode = QrCode.fromData(
      data: widget.ticketData['_id'],
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
    log("TIcket Data : ${widget.ticketData}");
    log("Ticket ID Data : ${widget.ticketData['_id']}");
    makeQr();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // showQr = false;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Tickets",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: PopScope(
        canPop: !showQr,
        onPopInvoked: (didPop) {
          setState(() {
            showQr = false;
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: TSizes.displayHeight(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: TSizes.defaultSpace,
                      left: TSizes.defaultSpace,
                      bottom: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      RepaintBoundary(
                        key: qrKey,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: dark
                                ? TColors.lightDarkBackground
                                : TColors.primary,
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
                                  child: CachedNetworkImage(
                                    imageUrl: widget.ticketData['event']
                                        ['eventImages'][0],
                                    height:
                                        TSizes.displayHeight(context) * 0.24,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Container(
                                      // Add a placeholder widget if needed
                                      color: Colors
                                          .grey, // Placeholder background color
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      // Add an error widget if needed
                                      color:
                                          Colors.red, // Error background color
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),

                              MyTicketDetailsContainer(
                                data: widget.ticketData,
                                onCapture: () {
                                  saveWidgetImageIntoGallery(context);
                                },
                              ),

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
                                // ticketId: widget.ticketData['tickets']['_id'],
                                ticketId: widget.ticketData['_id'],
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showQr = !showQr;
                });
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: !showQr ? 0 : 5.0, sigmaY: !showQr ? 0 : 5.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastEaseInToSlowEaseOut,
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
            ),
          ],
        ),
      ),
    );
  }
}
