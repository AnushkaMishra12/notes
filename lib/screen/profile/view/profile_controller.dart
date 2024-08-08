import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null && pickedFile.path.isNotEmpty) {
        selectedImagePath.value = pickedFile.path;
        debugPrint("Image selected: ${pickedFile.path}");
      } else {
        selectedImagePath.value = ''; // Clear the path if no image is selected
        Get.snackbar(
          'No Image',
          'No image selected.',
          snackPosition: SnackPosition.BOTTOM,
        );
        debugPrint("No image selected.");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      debugPrint("Error occurred: $e");
    }
  }
}
