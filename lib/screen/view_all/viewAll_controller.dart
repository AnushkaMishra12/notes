import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dashboard/data/response_data.dart';

class ViewAllController extends GetxController {
  var notes = <ResponseData>[].obs;
  var isLoadingMore = false.obs;
  var currentPage = 0;
  final int notesPerPage = 4;
  var isPageAvailable = true;

  @override
  void onInit() {
    super.onInit();
    loadMoreNotes();
    final arguments = Get.arguments as Map<String, dynamic>;
    // notes.addAll(arguments['notes'] as List<ResponseData>);
  }

  void loadMoreNotes() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    final moreNotes = await _fetchNotes(currentPage + 1);
    if (moreNotes.length < 4) {
      isPageAvailable = false;
    }
    debugPrint("=============> ${moreNotes.length}");
    notes.addAll(moreNotes);
    currentPage++;
    isLoadingMore.value = false;
  }

  Future<List<ResponseData>> _fetchNotes(int page) async {
    String apiUrl =
        'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks?page=$page&limit=$notesPerPage';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ResponseData.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
