import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screen/dashboard/data/ResponseData.dart';
import '../screen/login/data/login_response.dart';

class AuthRepo {
  static String url =
      'https://6690d550c0a7969efd9db690.mockapi.io/api/v1/tasks';

  static Future<List<ResponseData>> fetchTask() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => ResponseData.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<void> createTask(String title, String description) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'description': description}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  static Future<void> updateTask(String id, Map<String, dynamic> data) async {
    final updateUrl = '$url/$id';
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  static Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  void login(
      Object req, Function(LoginResponse?, String? error) callback) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: req,
      );
      debugPrint("====================> ${response.toString()}");
      if (response.statusCode == 200) {
        callback.call(LoginResponse.fromJson(jsonDecode(response.body)), null);
      } else {
        callback(null, response.reasonPhrase); // Failed login
      }
    } catch (e) {
      e.printError();
      callback(null, e.toString());
    }
  }
}
