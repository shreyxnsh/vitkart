import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vitkart/utils/API/api_routes.dart';



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
}
