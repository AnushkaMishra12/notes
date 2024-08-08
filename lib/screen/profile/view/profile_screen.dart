import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:notes/screen/profile/view/profile_controller.dart';
import '../../../Widget/ImageSourceDialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                final imageProvider =
                    controller.selectedImagePath.value.isNotEmpty
                        ? FileImage(File(controller.selectedImagePath.value))
                        : const AssetImage('assets/images/img_1.png')
                            as ImageProvider;
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: imageProvider,
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ImageSourceDialog(controller: controller),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
