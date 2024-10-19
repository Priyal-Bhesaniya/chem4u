import 'package:chemlab_flutter_project/Controller/Signup_page_controller.dart';
import 'package:chemlab_flutter_project/Controller/otp_controller.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  // Initialize the controller using Get.put()
  final SignupPageController controller = Get.put(SignupPageController());
  final _formKey = GlobalKey<FormState>(); // Correct use of GlobalKey for form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey, // Form widget for validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Scientist image at the top
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/Login_page.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 30),

                  // "Sign Up" text
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
                      () => TextFormField(
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

                  // Password input field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 181, 198),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => TextFormField(
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

                  // Mobile input field with validation
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 104, 181, 198),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => TextFormField(
                        controller: controller.mobile,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.black),
                          hintText: 'Mobile',
                          errorText: controller.mobileError.value,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        onChanged: (value) {
                          controller.validateMobile(value);
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
                      () => TextFormField(
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
                      if (_formKey.currentState!.validate()) {
                        // Attempt to register the user
                        controller.registerUser();
                        // Proceed if validation passed
                        if (controller.isValid) {
                          // Trigger OTP sending and navigate to OTP Verification
                          SignupPageController.instance.phoneAuthentication(
                            controller.mobile.text.trim(),
                          );
                          Get.toNamed('/OtpVerification');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 60),
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
