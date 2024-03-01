import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vitkart/app.dart';

void main() async {
  await GetStorage.init();
  runApp(const App());
}
