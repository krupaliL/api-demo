import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/controllers/home_controller.dart';
import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateController extends GetxController {
  static CreateController get instance => Get.find();

  final nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> createUser() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.users
      );
      Map body = {
        'name': nameController.text,
        'job': jobController.text,
      };

      log(jsonEncode(body), name: 'RegisterParam');
      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      log(response.statusCode.toString(), name: 'statusCode');
      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        log(jsonEncode(json), name: 'RegisterResponse');
        if (json['id'] != 0) {
          var id = json['id'];
          log(id, name: 'ID');

          final SharedPreferences prefs = await _prefs;

          await prefs.setString('id', id);
          nameController.clear();
          jobController.clear();

          HomeController.instance.getUsers();
          Get.back();
        } else {
          log(jsonDecode(response.body), name: 'AuthError');
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