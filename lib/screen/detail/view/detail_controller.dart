import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Data/auth_repo.dart';
import '../../dashboard/data/response_data.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();
  final Rx<ResponseData?> listData = (Get.arguments as ResponseData?).obs;
  final titleController = TextEditingController(text: '');
  final descriptionController = TextEditingController(text: '');
  final editable = false.obs;

  @override
  void onInit() {
    titleController.text = listData.value?.title ?? '';
    descriptionController.text = listData.value?.description ?? '';
    super.onInit();
  }

  Future<void> updateNotes() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Title must not be empty',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await AuthRepo.updateNotes(listData.value!.id.toString(), {
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'isCompleted': listData.value?.isCompleted ?? false,
        // 'updatedAt': DateTime.now().toString(),
        'pinned': listData.value?.pinned ?? false,
        'color': listData.value?.color
      });
      Get.snackbar('Success', 'Note updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update note',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
