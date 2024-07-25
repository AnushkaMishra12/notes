import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Data/auth_repo.dart';
import '../data/response_data.dart';

class DashBoardController extends GetxController {
  var allNotes = <ResponseData>[].obs;
  var completedNotes = <ResponseData>[].obs;
  var pendingNotes = <ResponseData>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var filteredNotes = <ResponseData>[].obs;
  var loginResponse = ResponseData(title: '', description: '').obs;
  final formKey = GlobalKey<FormState>();
  static DashBoardController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    searchQuery.listen((query) {
      filterNotes(query);
    });
  }

  void fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await AuthRepo.fetchNotes();
      allNotes.assignAll(tasks);
      completedNotes
          .assignAll(tasks.where((task) => task.isCompleted ?? false).toList());
      pendingNotes
          .assignAll(tasks.where((task) => task.pinned ?? false).toList());
      filterNotes(searchQuery.value);
    } finally {
      isLoading(false);
    }
  }

  void createTask(String title, String description) async {
    try {
      await AuthRepo.createNotes(title, description);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task');
    }
  }

  void updateTask(ResponseData updatedTask) {
    int index = allNotes.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      allNotes[index] = updatedTask;
    }
    if (updatedTask.isCompleted ?? false) {
      completedNotes[index] = updatedTask;
    } else {
      pendingNotes[index] = updatedTask;
    }
  }

  void deleteTask(String id) async {
    try {
      await AuthRepo.deleteNotes(id);
      allNotes.removeWhere((task) => task.id == id);
      completedNotes.removeWhere((task) => task.id == id);
      pendingNotes.removeWhere((task) => task.id == id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  void filterNotes(String query) {
    final filtered = allNotes.where((note) {
      final title = note.title?.toLowerCase() ?? '';
      final description = note.description?.toLowerCase() ?? '';
      return title.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();
    filteredNotes.assignAll(filtered);
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
