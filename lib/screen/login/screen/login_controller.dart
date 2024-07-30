import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';
import '../../../Data/auth_repo.dart';
import '../data/login_response.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final repo = AuthRepo();
  var isLoading = false.obs;
  var loginResponse = LoginResponse(id: 0).obs; // Default id to 0
  var isLoggedIn = false.obs;
  static LoginController get to => Get.find();
  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() async {
    isLoading(true);
    try {
      final response = await repo.login(
        usernameController.text,
        passwordController.text,
      );
      if (response != null) {
        loginResponse.value = response;
        saveLoginData(response);
        Get.offAndToNamed(AppRoutes.dashboard);
      } else {
        isLoading(false);
        Get.snackbar(
          "Login Failed",
          "Invalid login credentials.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      isLoading(false);
      Get.snackbar(
        "Login Failed",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void saveLoginData(LoginResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.token ?? '');
    await prefs.setString('username', response.email ?? '');
    await prefs.setString('image', response.image ?? '');

    final userId =
        response.username?.toString() ?? '0'; // Ensure userId is a String
    await prefs.setString('id', userId); // Save user ID as String
    AuthRepo.id = response.username ?? ''; // Set the static userId as num
    isLoggedIn(true);
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final username = prefs.getString('username');

    if (token != null && username != null) {
      AuthRepo.id = username; // Set the static username
      debugPrint("Username set: ${AuthRepo.id}"); // Debug print
      loginResponse.value = LoginResponse(
        token: token,
        email: username,
        id: 0, // You can set a default value for id if it's not needed
      );
      isLoggedIn(true);
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    AuthRepo.id = '';
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
