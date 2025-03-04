import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/controllers/home_controller.dart';
import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UpdateController extends GetxController {
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  Rx<UserUpdate> user = UserUpdate.empty().obs;

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    // var url = Uri.parse(
    //     '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getUsers}/2');
    //
    // http.Response response = await http.get(url);
    // final json = jsonDecode(response.body);
    // user.add(UserUpdate.fromJson(json))
    nameController.text = 'morpheus';
    jobController.text = 'zion resident';
  }

  Future<void> updateUser(String userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.users}/$userId'
      );
      Map body = {
        'name': nameController.text,
        'job': jobController.text,
      };

      log(jsonEncode(body), name: 'UpdateParam');
      final response = await http.put(url, body: jsonEncode(body), headers: headers);

      log(response.statusCode.toString(), name: 'statusCode');
      if (response.statusCode == 200 || response.statusCode == 204) {
        final json = jsonDecode(response.body);
        log(jsonEncode(json), name: 'UpdateResponse');

        nameController.clear();
        jobController.clear();

        HomeController.instance.getUsers();
        Get.back();
      } else {
        log(jsonDecode(response.body), name: 'AuthError');
        throw jsonDecode(response.body)['Message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      Get.back();
      log(e.toString(), name: 'UpdateError');
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

  Future<void> updateUserName(String userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.users}/$userId');
      Map body = {
        'name': nameController.text, // Only updating the name
      };
      log(jsonEncode(body), name: 'UpdateSingleFieldParam');

      http.Response response =
          await http.patch(url, headers: headers, body: jsonEncode(body));

      log(response.statusCode.toString(), name: 'statusCode');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log(jsonEncode(json), name: 'updateUserNameResponse');

        nameController.clear();
        // HomeController.instance.getUsers();
        Get.back();
      } else {
        log(jsonDecode(response.body), name: 'Auth Error');
      }
    } catch (e) {
      log(e.toString(), name: 'UpdateSingleFieldError');
    }
  }
}