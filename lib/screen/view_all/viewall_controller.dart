import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dashboard/data/response_data.dart';

class ViewAllController extends GetxController {
  var notes = <ResponseData>[].obs;
  var isLoadingMore = false.obs;
  var currentPage = 0;
  final int notesPerPage = 10;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    notes.addAll(arguments['notes'] as List<ResponseData>);
  }

  void loadMoreNotes() async {
    if (isLoadingMore.value) return;

    isLoadingMore.value = true;

    final moreNotes = await _fetchNotes(currentPage + 1);
    notes.addAll(moreNotes);
    currentPage++;
    isLoadingMore.value = false;
  }

  Future<List<ResponseData>> _fetchNotes(int page) async {
    final String apiUrl =
        'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks?page=$page&limit=$notesPerPage';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ResponseData.fromJson(json)).toList();
      } else {
        // Handle server errors
        return [];
      }
    } catch (e) {
      // Handle network errors
      return [];
    }
  }
}
