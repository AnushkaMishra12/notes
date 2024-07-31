import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/ui_state.dart';
import '../screen/dashboard/data/response_data.dart';
import '../screen/login/data/login_response.dart';

class AuthRepo {
  static String url =
      'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks';
  static String loginUrl = 'https://dummyjson.com/auth/login';

  Future<LoginResponse?> login(String username, String password) async {
    final loginRequest =
        jsonEncode({'username': username, 'password': password});
    final url = Uri.parse(loginUrl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: loginRequest,
      );
      debugPrint("====================> ${response.toString()}");
      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        return loginResponse;
      } else {
        throw Exception('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Login failed: $e');
    }
  }

  static void fetchNotes(String userID, String query,
      Function(UiState<List<ResponseData>>) callback) async {
    callback.call(const Loading());
    final response =
        await http.get(Uri.parse("$url?userId=$userID&description=$query"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      debugPrint("all task data: $jsonResponse");

      final data =
          jsonResponse.map((task) => ResponseData.fromJson(task)).toList();
      if (data.isEmpty) {
        callback(const Error('No notes found'));
      } else {
        callback(Success(data));
      }
    } else {
      callback(const Error('Failed to load Notes'));
    }
  }

  static Future<void> createNotes(
      String title, String description, String userId) async {
    if (userId.isEmpty) {
      throw Exception('Username is not available');
    }
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
          {'title': title, 'description': description, 'userId': userId}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create Notes');
    }
  }

  static Future<void> updateNotes(String id, Map<String, dynamic> data) async {
    if (id.isEmpty) {
      throw Exception('Username is not available');
    }
    final updateUrl = '$url/$id';
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update Notes');
    }
  }

  static Future<void> deleteNotes(String id) async {
    if (id.isEmpty) {
      throw Exception('Username is not available');
    }
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete Notes');
    }
  }
}
