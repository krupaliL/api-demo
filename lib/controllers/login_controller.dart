import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../screens/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail
      );
      Map body = {
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
        if (json['token'] != null) {
          var token = json['token'];
          // print(token);
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          emailController.clear();
          passwordController.clear();
          Get.off(HomeScreen());
        } else {
          throw "${response.body} Token";
        }
      } else {
        throw response.body;
      }
    } catch (e) {
      Get.back();
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