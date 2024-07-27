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
      debugPrint('Updating note with ID: ${listData.value!.id}');
      debugPrint('Title: ${titleController.text.trim()}');
      debugPrint('Description: ${descriptionController.text.trim()}');
      debugPrint('Is Completed: ${listData.value?.isCompleted ?? false}');
      debugPrint('Pinned: ${listData.value?.pinned ?? false}');
      debugPrint('Color: ${listData.value?.color}');

      List<ResponseData> notes = await AuthRepo.fetchNotes();

      notes.sort((a, b) {
        DateTime aCreatedAt = DateTime.parse(a.createdAt!);
        DateTime bCreatedAt = DateTime.parse(b.createdAt!);
        return aCreatedAt.compareTo(bCreatedAt);
      });

      await AuthRepo.updateAllNotes(notes);
      Get.snackbar('Success', 'Updated successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      debugPrint('Failed to update note: $e');
      Get.snackbar('Error', 'Failed to update note',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
