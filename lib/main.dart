import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/routes/AppPages.dart';
import 'package:notes/routes/AppRoutes.dart';
import 'package:notes/screen/dashboard/view/DashBoardController.dart';
import 'package:notes/screen/login/screen/LoginController.dart';
import 'package:notes/themes/AppTheme.dart';

void main() {
  Get.put(LoginController());
  Get.put(DashBoardController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
