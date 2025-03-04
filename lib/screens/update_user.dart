import 'package:api_demo/controllers/update_controller.dart';
import 'package:api_demo/screens/widgets/input_fields.dart';
import 'package:api_demo/screens/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({super.key});

  @override
  Widget build(BuildContext context) {
    final updateController = Get.put(UpdateController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'Update your details',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                InputTextFieldWidget(updateController.nameController, 'Name'),
                SizedBox(height: 20),
                // InputTextFieldWidget(updateController.jobController, 'Job'),
                SizedBox(height: 30),
                SubmitButton(
                  onPressed: () => updateController.updateUserName('2'),
                  title: 'Save',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
