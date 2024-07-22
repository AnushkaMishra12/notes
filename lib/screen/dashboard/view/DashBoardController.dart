import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Data/AuthRepo.dart';
import '../data/ResponseData.dart';

class DashBoardController extends GetxController {
  var allTasks = <ResponseData>[].obs;
  var completedTasks = <ResponseData>[].obs;
  var pendingTasks = <ResponseData>[].obs;
  var isLoading = true.obs;
  var loginResponse = ResponseData(title: '', description: '').obs;

  final formKey = GlobalKey<FormState>();
  static DashBoardController get to => Get.find();

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await AuthRepo.fetchTask();
      allTasks.assignAll(tasks);
      completedTasks
          .assignAll(tasks.where((task) => task.isCompleted ?? false).toList());
      pendingTasks
          .assignAll(tasks.where((task) => task.pinned ?? false).toList());
    } finally {
      isLoading(false);
    }
  }

  void createTask(String title, String description) async {
    try {
      await AuthRepo.createTask(title, description);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task');
    }
  }

  void updateTask(ResponseData updatedTask) {
    int index = allTasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      allTasks[index] = updatedTask;
    }
    if (updatedTask.isCompleted ?? false) {
      completedTasks[index] = updatedTask;
    } else {
      pendingTasks[index] = updatedTask;
    }
  }

  void deleteTask(String id) async {
    try {
      await AuthRepo.deleteTask(id);
      allTasks.removeWhere((task) => task.id == id);
      completedTasks.removeWhere((task) => task.id == id);
      pendingTasks.removeWhere((task) => task.id == id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }
}
