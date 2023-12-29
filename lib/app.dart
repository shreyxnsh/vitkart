import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitkart/features/authentication/screens/login/login.dart';
import 'package:vitkart/utils/constants/text_strings.dart';
import 'package:vitkart/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    

    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
