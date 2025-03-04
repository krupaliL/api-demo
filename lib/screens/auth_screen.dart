import 'package:api_demo/controllers/login_controller.dart';
import 'package:api_demo/controllers/registration_controller.dart';
import 'package:api_demo/screens/widgets/input_fields.dart';
import 'package:api_demo/screens/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegistrationController registrationController = Get.put(RegistrationController());
  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: !isLogin.value ? Colors.white : Colors.blue.shade100,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: Text('Register'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.white : Colors.blue.shade100,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    isLogin.value ? loginWidget() : registerWidget()
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        // InputTextFieldWidget(registrationController.nameController, 'name'),
        // SizedBox(height: 20),
        InputTextFieldWidget(registrationController.emailController, 'email address'),
        SizedBox(height: 20),
        InputTextFieldWidget(registrationController.passwordController, 'password'),
        SizedBox(height: 30),
        SubmitButton(
          onPressed: () => registrationController.registerWithEmail(),
          title: 'Register',
        ),
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        // SizedBox(height: 20),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        SizedBox(height: 20),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        SizedBox(height: 30),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Login',
        ),
      ],
    );
  }
}