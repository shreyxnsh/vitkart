import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vitkart/common/widgets/products/products_cart/cancel_bid.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/common/widgets/products/products_cart/productsell.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';
import 'package:vitkart/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  final ProductData productId;

  const TBottomAddToCart({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {

    log("Product ID : ${productId.buyer}");
    void showSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    final String bidderId = UserDataService.getUserID();

    bool isBidder() {
      bool isBidder = false;

      for (var i in productId.bidders) {
        if (i.id == UserDataService.getUserID()) {
          isBidder = true;
          break;
        }
      }

      return isBidder;
    }

    bool isSeller() {
      return productId.seller.id == UserDataService.getUserID();
    }

    bool hasSoldOut() {
      return (productId.buyer != null);
    }

    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkBackground : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {

            if (isSeller()) {
              showSnackBar(context, "You can't buy your own product!");
              return;
            }

            if(hasSoldOut()){
              showSnackBar(context, "This product has already been sold out!");
              return;
            }

            isBidder() ? 
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Cancel your bid'),
                content:
                    const Text('Are you sure you want to cancel your bid?'),
                actions: <Widget>[
                  
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
                            'Your request will be removed from the seller of this product, please wait for approval to know more details.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              if (DateTime.now()
                                      .difference(coundDown)
                                      .inSeconds <
                                  2) {
                                return;
                              }

                              Get.back();
                            },
                            child: Countdown(
                              seconds: 2,
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
                      log("Cancel Bid  Placing");
                      // await eventDetailController.createOrderIdApiHit(
                      //     context, controller);
                      // await Future.delayed(const Duration(seconds: 1));
                      // controller.success();
                      // controller.reset();

                      // write a put request to the server to place a bid for the product where i will have the productId and bidderId as the two parameters where i will have my product id and store the logged in user's id respectively to the placebid url

                      Map<String, dynamic> response =
                          await APIFunctions.cancelBid(
                              productId: productId.id, bidderId: bidderId);
                      log("Response : $response");
                      if (response['isSuccess']) {
                        // showSnackBar(context, "Bid Placed Successfully");
                        Get.snackbar(
                          "Success",
                          "Bid Cancelled Successfully",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: TColors.success,
                        );
                        Get.to(CancelBidSuccess());
                        return;
                      }
                      if (response['message'] ==
                          "You have already placed a bid on this product") {
                        // showSnackBar(context,
                        //     "You have already placed a bid on this product!");
                        Get.snackbar(
                          "Error",
                          "You have already placed a bid on this product",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: TColors.error,
                        );
                        return;
                      }
                      log("Error : ${response['message'].toString()}");
                      // showSnackBar(
                      //     context, "Oops, ${response['message'].toString()}");
                      Get.snackbar(
                        "Error",
                        "Oops, ${response['message'].toString()}",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: TColors.error,
                      );
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('No',
                        style: TextStyle(color: TColors.primary)),
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      // controller.success();
                      // controller.reset();
                      Get.back();
                    },
                  ),
                ],
              ),
            )
            
            : 

            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Place a bid'),
                content:
                    const Text('Do you want to place a bid for this product?'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('No',
                        style: TextStyle(color: TColors.primary)),
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      // controller.success();
                      // controller.reset();
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
                            'Your request will be sent to the seller of this product, please wait for approval to know more details.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              if (DateTime.now()
                                      .difference(coundDown)
                                      .inSeconds <
                                  2) {
                                return;
                              }

                              Get.back();
                            },
                            child: Countdown(
                              seconds: 2,
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
                      log("BID Placing");
                      // await eventDetailController.createOrderIdApiHit(
                      //     context, controller);
                      // await Future.delayed(const Duration(seconds: 1));
                      // controller.success();
                      // controller.reset();

                      // write a put request to the server to place a bid for the product where i will have the productId and bidderId as the two parameters where i will have my product id and store the logged in user's id respectively to the placebid url

                      Map<String, dynamic> response =
                          await APIFunctions.placeBid(
                              productId: productId.id, bidderId: bidderId);
                      log("Response : $response");
                      if (response['isSuccess']) {
                        // showSnackBar(context, "Bid Placed Successfully");
                        Get.snackbar(
                          "Success",
                          "Bid Placed Successfully",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: TColors.success,
                        );
                        Get.to(const SellSuccessScreen());
                        return;
                      }
                      if (response['message'] ==
                          "You have already placed a bid on this product") {
                        // showSnackBar(context,
                        //     "You have already placed a bid on this product!");
                        Get.snackbar(
                          "Error",
                          "You have already placed a bid on this product",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: TColors.error,
                        );
                        return;
                      }
                      log("Error : ${response['message'].toString()}");
                      // showSnackBar(
                      //     context, "Oops, ${response['message'].toString()}");
                      Get.snackbar(
                        "Error",
                        "Oops, ${response['message'].toString()}",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: TColors.error,
                      );
                    },
                  ),
                ],
              ),
            );


            // Get.to(
            //   SellSuccessScreen()
            // );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: isBidder()
                ? TColors.textPrimary
                : isSeller()
                    ? TColors.darkBackground
                    : isBidder()
                        ? TColors.white
                        : TColors.primary,
          ),
          child: Text(
            isBidder()
                ? "Cancel your bid"
                : isSeller()
                    ? "You can't buy your own product"
                    : 
                        "Place a bid",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isSeller()
                      ? TColors.grey
                      : isBidder()
                          ? TColors.primary
                          : TColors.textWhite,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  // Future<Map<String, dynamic>> placeBid(String bidderId) async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'token': UserDataService.getToken()
  //   };
  //   var request = http.Request('PUT', Uri.parse(placeBidUrl));
  //   request.body = json.encode({"bidderId": bidderId, "productId": productId});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();
  //   log("placeBidStatus : ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> jsonResponse =
  //         jsonDecode(await response.stream.bytesToString()); // Convert to JSON
  //     jsonResponse['isSuccess'] = true;
  //     log("placeBidStatus : $jsonResponse");
  //     // showSuccessToast(context, "Success ");
  //     return jsonResponse;
  //   } else {
  //     Map<String, dynamic> jsonResponse =
  //         jsonDecode(await response.stream.bytesToString()); // Convert to JSON
  //     jsonResponse['isSuccess'] = false;
  //     log("placeBidStatus : $jsonResponse");
  //     // showErrorToast(context, "Oops, $jsonResponse");
  //     return jsonResponse;
  //   }
  // }
}
