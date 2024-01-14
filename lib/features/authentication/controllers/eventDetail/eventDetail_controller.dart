import 'package:get/get.dart';
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

  Future<void> createOrderIdApiHit() async {
    Map<String, dynamic> response = await APIFunctions.createOrderId(
      amount: double.parse((data['ticketTypes'][optionsSelection.value]
              ['totalPrice'])
          .toString()),
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
    Get.snackbar('Error', 'Something went wrong');
  }
}
