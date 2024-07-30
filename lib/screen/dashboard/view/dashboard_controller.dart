import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/auth_repo.dart';
import '../../../api/ui_state.dart';
import '../data/response_data.dart';

class DashBoardController extends GetxController {
  // var allNotes = <ResponseData>[].obs;
  // var allNotes =
  //     Rx<UiState<List<ResponseData>>>(const None()); // if uiState is used
  Rx<UiState<List<ResponseData>>> allNotes =
      Rx<UiState<List<ResponseData>>>(const None());
  var completedNotes = <ResponseData>[].obs;
  var pendingNotes = <ResponseData>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var filteredNotes = <ResponseData>[].obs;
  var loginResponse = ResponseData(title: '', description: '').obs;
  final formKey = GlobalKey<FormState>();
  final userImage = ''.obs;
  static DashBoardController get to => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    final image = prefs.getString('image');
    userImage.value = image ?? '';
    debugPrint("User ID onInit: ${AuthRepo.id}");
    fetchTasks();
    searchQuery.listen((query) {
      filterNotes(query);
    });
  }

  void fetchTasks() async {
    final userId = AuthRepo.id;
    debugPrint("User ID: $userId");

    if (userId.isEmpty) {
      allNotes.value = const Error('User ID not available');
      return;
    }

    allNotes.value = const Loading();
    try {
      isLoading(true);
      var arr2 = await AuthRepo.fetchNotes();
      debugPrint("Error fetching tasks: $arr2");
      if (arr2.isEmpty) {
        allNotes.value = const Error('No notes found');
        return;
      }
      var tasks = arr2.where((item) => item.userId == userId).toList();
      debugPrint("Filtered tasks: ${tasks.length}");

      if (tasks.isEmpty) {
        allNotes.value = Error("No notes found for user ID: $userId");
      } else {
        allNotes.value = Success(tasks);
        filterNotes(searchQuery.value);
        completedNotes.assignAll(
            tasks.where((task) => task.isCompleted ?? false).toList());
        pendingNotes
            .assignAll(tasks.where((task) => task.pinned ?? false).toList());
      }
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
      allNotes.value = Error(e.toString());
    } finally {
      isLoading(false);
    }
  }
// finally {
  //   isLoading(false);
  // }

  void createTask(String title, String description) async {
    try {
      final userId = AuthRepo.id; // Ensure userId is fetched from AuthRepo
      if (userId.isEmpty) {
        Get.snackbar('Error', 'User ID not available');
        return;
      }
      await AuthRepo.createNotes(title, description, userId);
      fetchTasks();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task');
    }
  }

  void updateTask(ResponseData updatedTask) {
    // int index = allNotes.indexWhere((task) => task.id == updatedTask.id);
    // if (index != -1) {
    //   allNotes[index] = updatedTask;
    //   sortNotesByDate();
    // }
    int index = (allNotes.value as Success<List<ResponseData>>)
        .data
        .indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      (allNotes.value as Success<List<ResponseData>>).data[index] = updatedTask;
    } //if uiState is used
    if (updatedTask.isCompleted ?? false) {
      completedNotes[index] = updatedTask;
    } else {
      pendingNotes[index] = updatedTask;
    }
  }

  void deleteTask(String id) async {
    try {
      final userId = AuthRepo.id; // Ensure userId is fetched from AuthRepo
      if (userId.isEmpty) {
        Get.snackbar('Error', 'User ID not available');
        return;
      }
      await AuthRepo.deleteNotes(id);
      // allNotes.removeWhere((task) => task.id == id);
      var notes = (allNotes.value as Success<List<ResponseData>>)
          .data; // ui state is used
      completedNotes.removeWhere((task) => task.id == id);
      pendingNotes.removeWhere((task) => task.id == id);
      allNotes.value = Success(notes); //if ui state is used
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  // void filterNotes(String query) {
  //   final filtered = allNotes.where((note) {
  //     final title = note.title?.toLowerCase() ?? '';
  //     final description = note.description?.toLowerCase() ?? '';
  //     return title.contains(query.toLowerCase()) ||
  //         description.contains(query.toLowerCase());
  //   }).toList();
  //   filteredNotes.assignAll(filtered);
  // }

  void filterNotes(String query) {
    //ui state is used
    if (allNotes.value is Success) {
      final notes = (allNotes.value as Success<List<ResponseData>>).data;
      final filtered = notes.where((note) {
        final title = note.title?.toLowerCase() ?? '';
        final description = note.description?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase()) ||
            description.contains(query.toLowerCase());
      }).toList();
      filteredNotes.assignAll(filtered);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
