import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/AuthRepo.dart';
import '../../../routes/AppRoutes.dart';
import '../data/login_response.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final repo = AuthRepo();
  var isLoading = false.obs;
  var loginResponse = LoginResponse(token: '', email: '').obs;
  var isLoggedIn = false.obs;

  static LoginController get to => Get.find();

  void login() {
    isLoading(true);
    repo.login(
        jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
        }), (data, error) {
      isLoading(false);
      if (data != null) {
        loginResponse.value = data;
        saveLoginData(data);
        Get.offAndToNamed(AppRoutes.dashboard,
            arguments: {"data": data, "id": 0});
      } else {
        Get.snackbar(
          "Login Failed",
          error ?? "Unknown error",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  void saveLoginData(LoginResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.token ?? '');
    await prefs.setString('username', response.email ?? '');
    isLoggedIn(true);
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');
    if (token != null && username != null) {
      loginResponse.value = LoginResponse(token: token, email: username);
      isLoggedIn(true);
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn(false);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
