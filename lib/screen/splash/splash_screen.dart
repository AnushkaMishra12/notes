import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString(USER_ID);

    if (token != null && userId != null) {
      Get.offAllNamed(AppRoutes.dashboard, arguments: userId);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
