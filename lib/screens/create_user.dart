import 'package:api_demo/controllers/create_controller.dart';
import 'package:api_demo/screens/widgets/input_fields.dart';
import 'package:api_demo/screens/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateController());
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
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                    InputTextFieldWidget(createController.nameController, 'Name'),
                    SizedBox(height: 20),
                    InputTextFieldWidget(createController.jobController, 'Job'),
                    SizedBox(height: 30),
                    SubmitButton(
                      onPressed: () => createController.createUser(),
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
