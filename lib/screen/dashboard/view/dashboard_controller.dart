import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Data/auth_repo.dart';
import '../../../api/ui_state.dart';
import '../../../routes/app_routes.dart';
import '../data/response_data.dart';

class DashBoardController extends GetxController {
  // var allNotes = <ResponseData>[].obs;
  // var allNotes =
  //     Rx<UiState<List<ResponseData>>>(const None()); // if uiState is used
  Rx<UiState<List<ResponseData>>> allNotes =
      Rx<UiState<List<ResponseData>>>(const None());

  final String? userId = Get.arguments;

  var filteredNotes = <ResponseData>[].obs;
  var loginResponse = ResponseData(title: '', description: '').obs;
  final formKey = GlobalKey<FormState>();
  final userImage = ''.obs;
  static DashBoardController get to => Get.find();
  final TextEditingController searchController = TextEditingController();
  @override
  Future<void> onInit() async {
    debugPrint("=============> userId : $userId");

    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    final image = prefs.getString('image');
    userImage.value = image ?? '';
    fetchTasks();
  }

  void fetchTasks() async {
    debugPrint("User ID: $userId");
    if (userId == null || userId?.isEmpty == true || userId == '0') {
      allNotes.value = const Error('User ID not available');
      return;
    }
    try {
      AuthRepo.fetchNotes(userId!, searchController.text.trim(), (state) {
        allNotes.value = state;
      });
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
      allNotes.value = Error(e.toString());
    } finally {}
  }

  void createTask(String title, String description) async {
    try {
      // Ensure userId is fetched from AuthRepo
      if (userId == null || userId?.isEmpty == true || userId == '0') {
        Get.snackbar('Error', 'User ID not available');
        return;
      }

      await AuthRepo.createNotes(title, description, userId!);
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
  }

  void deleteTask(String id) async {
    try {
      await AuthRepo.deleteNotes(id);
      // allNotes.removeWhere((task) => task.id == id);
      var notes = (allNotes.value as Success<List<ResponseData>>)
          .data; // ui state is used
      fetchTasks();
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

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
