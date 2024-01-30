import 'dart:developer';
import 'dart:ui';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/controllers/eventDetail/eventDetail_controller.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/events/screens/ticket.dart';
import 'package:vitkart/features/events/screens/widgets/previewEventCard.dart';
import 'package:vitkart/features/events/screens/widgets/previewPayment.dart';
import 'package:vitkart/features/events/screens/widgets/previewSummary.dart';
import 'package:vitkart/navigation_menu.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/colors.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class PreviewEventOrderScreen extends StatefulWidget {
  const PreviewEventOrderScreen(
      {super.key, required this.orderIdData, required this.evenDdata});

  final Map<String, dynamic> orderIdData;
  final Map<String, dynamic> evenDdata;
  @override
  State<PreviewEventOrderScreen> createState() =>
      _PreviewEventOrderScreenState();
}

class _PreviewEventOrderScreenState extends State<PreviewEventOrderScreen> {
  Razorpay? _razorpay;

  EventDetailController eventDetailController = Get.find();

  late DateTime screenFirstOpenAt;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds

    log("responsee : ${response.signature} : ${response.paymentId} : ${response.orderId}");
    if (response.paymentId == null) {
      showErrorToast(context, "PaymentId is null");
      return;
    }
    if (response.orderId == null) {
      showErrorToast(context, "OrderId is null");
      return;
    }

    // update the order status
    Map<String, dynamic> updatePaymentStatus =
        await APIFunctions.updatePaymentStatus(
      orderId: response.orderId!,
    );

    if (!updatePaymentStatus['isSuccess']) {
      showErrorToast(context, updatePaymentStatus['message']);
      return;
    }

    Map<String, dynamic> ticket = await APIFunctions.createEventTicekt(
        userId: UserDataService.getUserID(),
        eventId: eventDetailController.data["_id"],
        ticketTypeId: eventDetailController.data["ticketTypes"]
            [eventDetailController.optionsSelection.value]["_id"],
        orderId: response.orderId!,
        paymentId: response.paymentId!);

    if (ticket['isSuccess']) {
      showSuccessToast(context, "Success : ${response.paymentId}");
      Get.to(() => TicketScreen(
            ticketData: ticket,
          ));
      return;
    }

    showErrorToast(context, ticket['message'] ?? "Something went wrong");
    return;

    // if (response.signature == null) {
    //   showErrorToast(context, "Signature is null");
    //   return;
    // }
    // Hit Create Ticket API

    // Future.delayed(Duration(seconds: 2), () {
    // Navigate to TicketScreen using Get.to

    // })
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showErrorToast(context, "Error : ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    showSuccessToast(context, "External Wallet : ${response.walletName}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    log("initState : ${widget.orderIdData} : ${widget.evenDdata}");
    screenFirstOpenAt = DateTime.now();
    _razorpay = Razorpay();

    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment() async {
    var options = {
      'key': 'rzp_test_BQfWCSPjfpPmye',
      'amount': widget.orderIdData['amount'], //rs 200
      'name': 'VITKART Events',
      'order_id': widget.orderIdData['order_id'],
      'description': widget.orderIdData['event'],
      'prefill': {
        'contact': '91XXXXXXXX',
        'email': 'test@gmail.com',
      },
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print("Error in razorpay :  $e");
    }
  }

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
                  loadingIcon: SizedBox(
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
                      width: 55,
                      child: Center(child: Icon(Icons.check_rounded))),
                  icon: const SizedBox(
                      width: 55,
                      child: Center(child: Icon(Iconsax.arrow_right_34))),
                  action: (controller) async {
                    controller.loading(); //starts loading animation
                    await Future.delayed(const Duration(seconds: 3));
                    controller.success(); //starts success animation
                    await Future.delayed(const Duration(seconds: 1));
                    controller.reset();
                    makePayment();
                  },
                  child: Center(
                      child: Text(
                    'Place Order',
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
              ],
            ),
          ),
        ),
        appBar: TAppBar(
          showBackArrow: false,
          title: Text('Preview Order',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  title: Text("Please Note",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: TColors.warning)),
                  message: Text(
                      "If you go back, your order will be considered as failure. And you will have to place order again in ${screenFirstOpenAt.add(Duration(minutes: 10)).difference(DateTime.now()).inMinutes} minutes.",
                      style: Theme.of(context).textTheme.bodyText1!),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const NavigationMenu(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        "Yes",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: TColors.primary),
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "No",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: TColors.primary),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PreviewEventCard(data: widget.evenDdata),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  PreviewOrderSummaryCard(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // PreviewPaymentCard(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
