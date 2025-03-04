import 'package:api_demo/controllers/delete_controller.dart';
import 'package:api_demo/screens/create_user.dart';
import 'package:api_demo/screens/update_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/home_controller.dart';
import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    // homeController.getUsers();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              final SharedPreferences prefs = await _prefs;
              prefs.clear();
              Get.offAll(AuthScreen());
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.userList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: homeController.userList.length,
          itemBuilder: (context, index) {
            final user = homeController.userList[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.3,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Spacer(),
                  // SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                            radius: 30,
                          ),
                          SizedBox(width: 20),
                          Text('ID: ${user.id}', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 14),
                        // maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                      ),
                    ],
                  ),
                  Spacer(),
                  // SizedBox(width: 20),

                  IconButton(onPressed: () => Get.to(UpdateUser()), icon: Icon(Icons.edit)),
                  IconButton(onPressed: () => Get.put(DeleteController()).deleteUser('2'), icon: Icon(Icons.delete_rounded)),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(CreateUser()),
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
