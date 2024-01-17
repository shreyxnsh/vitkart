import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/features/events/screens/previewOrder.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/API/userDataService.dart';

class EventDetailController extends GetxController {
  RxInt optionsSelection = (0).obs;
  Map<String, dynamic> data = {};
  RxInt totalTickets = 0.obs;
  RxInt ticketsLeft = 0.obs;
  void ticektCountUpdate() {
    int total = 0;
    int sold = 0;
    for (Map<String, dynamic> ticket in data['ticketTypes']) {
      total += int.parse(ticket['availableQuantity'].toString());
      sold += int.parse(ticket['soldQuantity'].toString());
    }
    totalTickets.value = total;
    ticketsLeft.value = total - sold;
  }

  double getTotoalPrice() {
    if (data['ticketTypes'][optionsSelection.value]['totalPrice'] == null) {
      double basePrice = double.parse(
          data['ticketTypes'][optionsSelection.value]['basePrice'].toString());
      return basePrice + (basePrice * 0.18);
    }
    return double.parse(
        data['ticketTypes'][optionsSelection.value]['totalPrice'].toString());
  }

  String getBannerImage() {
    return data['eventImages'][1];
  }

  Future<void> createOrderIdApiHit(BuildContext context) async {
    log("event id : ${data['_id']}");
    Map<String, dynamic> response = await APIFunctions.createOrderId(
      eventId: data['_id'],
      amount: getTotoalPrice(),
      name: UserDataService.getUserName(),
      regNo: UserDataService.getUserRegID(),
      eventName: data['eventName'],
    );
    if (response['isSuccess']) {
      Get.to(() => PreviewEventOrderScreen(
            evenDdata: data,
            orderIdData: response,
          ));
      return;
    }
    showErrorToast(context, response['message']);
  }

  DateTime getStartTime() {
    return DateTime.parse(data['eventStartTime'].toString());
  }

  DateTime getEndTime() {
    return DateTime.parse(data['eventEndTime'].toString());
  }

  DateTime getEventDate() {
    return DateTime.parse(data['eventDate'].toString());
  }
}
