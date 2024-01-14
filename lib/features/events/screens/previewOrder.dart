import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/events/screens/ticket.dart';
import 'package:vitkart/features/events/screens/widgets/previewEventCard.dart';
import 'package:vitkart/features/events/screens/widgets/previewPayment.dart';
import 'package:vitkart/features/events/screens/widgets/previewSummary.dart';
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    showSuccessToast(context, "Success : ${response.paymentId}");
    log("responsee : ${response.signature} : ${response.paymentId} : ${response.orderId}");
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to TicketScreen using Get.to
      Get.to(() => TicketScreen());
    });
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
          title: Text('Preview Order',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
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
        ));
  }
}
