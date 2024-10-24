import 'package:chemlab_flutter_project/Controller/Signup_page_controller.dart';
import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final SignupPageController controller = Get.put(SignupPageController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/Login_page.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),

                  
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 181, 198),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => TextFormField(
                        controller: controller.username,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          hintText: 'Username',
                          errorText: controller.usernameError.value,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        onChanged: (value) {
                          controller.validateUsername(value);
                        },
                        validator: (value) {
                          if (controller.usernameError.value != null) {
                            return controller.usernameError.value;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Password field
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 181, 198),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => TextFormField(
                        controller: controller.password,
                        obscureText: true, // You can add a toggle for visibility if needed
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          hintText: 'Password',
                          errorText: controller.passwordError.value,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        onChanged: (value) {
                          controller.validatePassword(value);
                        },
                        validator: (value) {
                          if (controller.passwordError.value != null) {
                            return controller.passwordError.value;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Email field
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 181, 198),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => TextFormField(
                        controller: controller.email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          hintText: 'E-mail',
                          errorText: controller.emailError.value,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        onChanged: (value) {
                          controller.validateEmail(value);
                        },
                        validator: (value) {
                          if (controller.emailError.value != null) {
                            return controller.emailError.value;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Sign-up button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Create UserModel without password
                        final user = UserModel(
                          username: controller.username.text,
                          email: controller.email.text,
                          password: '', // Store password securely
                        );

                        // Register the user using the email and password
                        controller.registerUser(user.email, controller.password.text, user.username);
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please correct the errors in the form',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      backgroundColor: Color(0xFF2FA0B9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign up',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
