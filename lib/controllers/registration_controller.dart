import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/screens/home_screen.dart';
import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  // final nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail
      );
      Map body = {
        // 'name': nameController.text,
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };

      log(jsonEncode(body), name: 'RegisterParam');
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      log(response.statusCode.toString(), name: 'statusCode');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log(jsonEncode(json), name: 'RegisterResponse');
        if (json['id'] != 0) {
          var token = json['token'];
          log(token, name: 'TOKEN');
          // print(token);
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          // nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.off(HomeScreen());
        } else {
          log(jsonDecode(response.body), name: 'Auth Error');
          throw jsonDecode(response.body)['Message'] ?? 'Unknown error occurred';
        }
      } else {
        log(jsonDecode(response.body), name: 'Auth Error');
        throw jsonDecode(response.body)['Message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      Get.back();
      log(e.toString(), name: 'AuthError');
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
      });
    }
  }
}