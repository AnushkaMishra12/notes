import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../login/screen/login_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    loginController.checkLoginStatus();

    return Obx(() {
      if (loginController.isLoggedIn.value) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutes.dashboard);
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
