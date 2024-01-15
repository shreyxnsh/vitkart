import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:vitkart/features/authentication/screens/register/widget/cherryToast.dart';
import 'package:vitkart/utils/API/api_functions.dart';
import 'package:vitkart/utils/constants/colors.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<File?> startImageCrop(
      XFile imageFile, BuildContext context) async {
    File imageTemporary = File(imageFile.path);
    final Directory extdir = await getApplicationDocumentsDirectory();
    String duplicateFilePath = extdir.path;
    final fileName = path.basename(imageTemporary.path);
    final saveto = '$duplicateFilePath/$fileName';
    final File newImage = await imageTemporary.copy(saveto);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: newImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Your Image',
          toolbarColor: TColors.darkBackground,
          cropGridColor: TColors.darkBackground,
          statusBarColor: TColors.lightDarkBackground,
          cropFrameColor: TColors.primary,
          showCropGrid: false,
          toolbarWidgetColor: TColors.light,
          backgroundColor: TColors.darkBackground,
          dimmedLayerColor: TColors.darkBackground,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        // ignore: use_build_context_synchronously
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return File(croppedFile!.path);
  }

  static Future<XFile?> pickImage({bool fromCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    if (fromCamera) {
      // get camera permission if not granted
      PermissionStatus status = await Permission.camera.request();
      if (!status.isGranted) {
        Get.snackbar("Error", "Please grant camera permission");
        return null;
      }

      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return null;
      return image;
    } else {
      // get storage permission if not granted
      PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        Get.snackbar("Error", "Please grant storage permission");
        return null;
      }

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image;
    }
  }

  static Future<File?> pickImageWithCrop(
      BuildContext context, bool isCamera) async {
    XFile? image = await THelperFunctions.pickImage(fromCamera: isCamera);
    if (image == null) {
      showErrorToast(context, "Please select an image");
      return null;
    }
    File? croppedImage = await THelperFunctions.startImageCrop(image, context);
    if (croppedImage == null) return File(image.path);
    return croppedImage;
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void copyToClipBoard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    showSuccessToast(context, "Copied to clipboard");
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}

class FutureBuilderFunctions {
  static Future<Map<String, dynamic>> fetchAdvityaEvents(
      String? category) async {
    Map<String, dynamic> result =
        await APIFunctions.getEvents(category: category);
    if (result['isSuccess']) {
      return result;
    }
    return {};
  }
}
