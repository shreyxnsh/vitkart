import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/API/api_routes.dart';
import 'package:vitkart/utils/API/userDataService.dart';

class APIFunctions {
  static Future<Map<String, dynamic>> createProduct({
    required Map<String, String> data,
    required List<String> filePaths,
  }) async {
    String token = GetStorage().read('token');
    var request =
        http.MultipartRequest('POST', Uri.parse('$createProductUrl$token'));
    request.fields.addAll(data);

    for (String path in filePaths) {
      request.files
          .add(await http.MultipartFile.fromPath('productImages', path));
    }
    log("-----------here-------------------");
    // request.files.add(await http.MultipartFile.fromPath(
    //     'productImages', '/C:/Users/Aviral/Pictures/IMG_20230620_000535.jpg'));
    // request.files.add(await http.MultipartFile.fromPath('productImages',
    //     '/C:/Users/Aviral/Pictures/Screenshot 2023-10-09 221230.png'));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'productImages', '/C:/Users/Aviral/Pictures/1.png'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());

      jsonResponse['isSuccess'] = true;
      log(jsonResponse.toString());
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());
      jsonResponse['isSuccess'] = false;
      log(jsonResponse.toString());
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> createUser(
      {required Map<String, String> data}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(registrationUrl));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = true;
      log(jsonResponse.toString());
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = false;
      log(jsonResponse.toString());
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> getEvents(
      {String? id, String? category}) async {
    String url = getEventsUrl +
        ((id != null || category != null) ? "?" : "") +
        (id == null ? "" : "id=$id") +
        (id == null
            ? ""
            : category == null
                ? ""
                : "&") +
        (category == null ? "" : "category=$category");
    log("code : $url");
    var request = http.Request('GET', Uri.parse(url));

    http.StreamedResponse response = await request.send();
    log("event : ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = true;
      log("event :" + jsonResponse.toString());
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = false;
      log(jsonResponse.toString());
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> otpVerify(
      {required String email, required String otp}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(otpVerificationUrl));
    request.body = json.encode({"userEmail": email, "otp": otp});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = true;
      log(jsonResponse.toString());
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = false;
      log(jsonResponse.toString());
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> createOrderId({
    required String name,
    required String regNo,
    required String eventName,
    required String eventId,
    required double amount,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(createOrderIdUrl));
    request.body = json.encode({
      "amount": amount,
      "userId": UserDataService.getUserID(),
      "eventId": eventId,
      "userRegId": UserDataService.getUserRegID(),
      "eventName": eventName
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());
      jsonResponse['isSuccess'] = true;
      log("createOrder :$jsonResponse");
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString());
      jsonResponse['isSuccess'] = false;
      log("createOrder :$jsonResponse");
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> createEventTicekt({
    required String userId,
    required String eventId,
    required String ticketTypeId,
    required String orderId,
    required String paymentId,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(createTicketUrl));
    log("ticket : $createTicketUrl");
    request.body = json.encode({
      "userId": userId,
      "eventId": eventId,
      "ticketTypeId": ticketTypeId,
      "orderId": orderId,
      "paymentId": paymentId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    log("ticket : ${response.statusCode}");

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = true;
      log("ticket : $jsonResponse");
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = false;
      log("ticket : $jsonResponse");
      return jsonResponse;
    }
  }

  static Future<Map<String, dynamic>> updatePaymentStatus({
    required String orderId,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PATCH', Uri.parse(updatePaymentStatusUrl));
    request.body = json.encode({"order_id": orderId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log("updatePaymentStatus : ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = true;
      log("updatePaymentStatus : $jsonResponse");
      return jsonResponse;
    } else {
      Map<String, dynamic> jsonResponse =
          jsonDecode(await response.stream.bytesToString()); // Convert to JSON
      jsonResponse['isSuccess'] = false;
      log("updatePaymentStatus : $jsonResponse");
      return jsonResponse;
    }
  }
}
