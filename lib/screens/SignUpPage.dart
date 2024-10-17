import 'package:chemlab_flutter_project/Controller/Signup_page_controller.dart';
import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final SignupPageController controller = Get.put(SignupPageController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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

                // Username input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        hintText: 'Username',
                        errorText: controller.usernameError.value,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      onChanged: (value) {
                        controller.validateUsername(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Mobile Number input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextField(
                      controller: controller.mobileNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.black),
                        hintText: 'Mobile Number',
                        errorText: controller.mobileNumberError.value,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      onChanged: (value) {
                        controller.validateMobileNumber(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Password input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextField(
                      controller: controller.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        hintText: 'Password',
                        errorText: controller.passwordError.value,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      onChanged: (value) {
                        controller.validatePassword(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Email input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextField(
                      controller: controller.email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                        hintText: 'E-mail',
                        errorText: controller.emailError.value,
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                      onChanged: (value) {
                        controller.validateEmail(value);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Sign-up button
                ElevatedButton(
                  onPressed: () {
                    controller.registerUser(
                      controller.email.text,
                      controller.password.text,
                    );

                    if (controller.isValid) {
                      final user = UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        username: controller.username.text.trim(),
                        mobileNumber: controller.mobileNumber.text.trim(),  // Pass mobile number
                      );

                      Get.to(LoginPage());
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
    );
  }
}
