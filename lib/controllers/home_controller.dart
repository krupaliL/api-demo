import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/models/user_model.dart';
import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getUsers
      );

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // log(jsonEncode(json), name: 'GetResponse');

        final data = json['data'];
        // log(jsonEncode(data), name: 'DATA');

        for (var users in data) {
          log(jsonEncode(users), name: 'User Data');
          userList.add(UserModel.fromJson(users));
          // log(message)
        }
      } else {
        throw response.body;
      }
    } catch (e) {
      Get.back();
      log(e.toString(), name: 'ERROR');
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
