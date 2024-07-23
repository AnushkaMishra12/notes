import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ColorPickerController extends GetxController {
  var selectedColor = Colors.white.obs;
  var isPasswordEnabled = false.obs;
  var isReminderEnabled = false.obs;

  void changeColor(Color color) {
    selectedColor.value = color;
  }
}
