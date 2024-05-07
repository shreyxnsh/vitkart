import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vitkart/common/widgets/appbar/appbar.dart';
import 'package:vitkart/common/widgets/products/products_cart/product_card_vertical.dart';
import 'package:vitkart/features/shop/screens/bids/widgets/bids_list.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/userDataService.dart';
import 'package:vitkart/utils/constants/sizes.dart';

class BidsScreen extends StatefulWidget {
  const BidsScreen({super.key});

  @override
  State<BidsScreen> createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> with WidgetsBindingObserver {
  // Stream<List<ProductData>> _fetchOrderList() async* {
  //   Map<String, dynamic> response = await APIFunctions.getMyOrdersList(
  //       buyerId: UserDataService.getUserID());

  //   List<ProductData> dataList = [];
  //   if (response['isSuccess']) {
  //     for (var item in response['products']) {
  //       dataList.add(ProductData.fromJson(item));
  //     }
  //     // log("resp    ${response}   ${dataList.length}");

  //     yield dataList;
  //   }
  //   yield dataList;
  // }

  StreamController<List<ProductData>> _streamController = StreamController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _streamController = StreamController<List<ProductData>>();
    _startPolling();
  }

  @override
  void dispose() {
    _stopPolling();
    _streamController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      Map<String, dynamic> response = await APIFunctions.getMyBidsList(
          bidderId: UserDataService.getUserID());

      List<ProductData> dataList = [];
      if (response['isSuccess']) {
        for (var item in response['products']) {
          dataList.add(ProductData.fromJson(item));
        }
        _streamController.add(dataList);
      }
    });
  }

  void _stopPolling() {
    _timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _startPolling();
    } else {
      _stopPolling();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Bids', style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: StreamBuilder(
            initialData: const <ProductData>[],
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              }

              return TBidListItems(
                productList: snapshot.requireData,
              );
            },
          ),
        ),
      ),
    );
  }
}
