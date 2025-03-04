import 'dart:convert';
import 'dart:developer';

import 'package:api_demo/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> deleteUser(String userId) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.users}/$userId'
      );

      final response = await http.delete(url, headers: headers);

      log(response.statusCode.toString(), name: 'statusCode');
      if (response.statusCode == 200 || response.statusCode == 204) {
        log('User deleted successfully', name: 'DeleteResponse');

        // Clear stored token if necessary
        final SharedPreferences prefs = await _prefs;
        await prefs.remove('token');

        Get.snackbar('Deleted', 'This user is removed for permanently', snackPosition: SnackPosition.BOTTOM,);
      } else {
        log(jsonDecode(response.body), name: 'AuthError');
        throw jsonDecode(response.body);
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