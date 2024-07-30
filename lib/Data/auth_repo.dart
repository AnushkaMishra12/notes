import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screen/dashboard/data/response_data.dart';
import '../screen/login/data/login_response.dart';

class AuthRepo {
  static String url =
      'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks';
  static String loginUrl = 'https://dummyjson.com/auth/login';
  static String id = '';

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
        AuthRepo.id =
            loginResponse.id.toString(); // Set user ID for further use
        debugPrint("User ID set in AuthRepo: ${AuthRepo.id}");
        return loginResponse;
      } else {
        throw Exception('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Login failed: $e');
    }
  }

  static Future<List<ResponseData>> fetchNotes() async {
    if (id.isEmpty) {
      throw Exception('Username is not available');
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // debugPrint("all task data: $jsonResponse");
      return jsonResponse.map((task) => ResponseData.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load Notes');
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
