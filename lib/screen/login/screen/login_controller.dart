import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_routes.dart';
import '../../../Data/auth_repo.dart';
import '../../../utils/constants.dart';
import '../data/login_response.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final repo = AuthRepo();
  var isLoading = false.obs;
  var loginResponse = LoginResponse(id: 0).obs;
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
        debugPrint("=============> ${response.toJson()}");

        saveLoginData(response);
        Get.offAndToNamed(AppRoutes.dashboard,
            arguments: response.id.toString());
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

    final userId = response.id?.toString() ?? '0'; // Ensure userId is a String
    await prefs.setString(USER_ID, userId); // Save user ID as String
    isLoggedIn(true);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
