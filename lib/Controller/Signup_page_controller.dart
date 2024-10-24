import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/Repository/User_repository.dart';
import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  // Singleton instance
  static SignupPageController get instance => Get.find(); // This works after Get.put() is called

  // TextEditingControllers for form fields
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // Error messages for validation (RxnString allows null values)
  RxnString usernameError = RxnString(null);
  RxnString passwordError = RxnString(null);
  RxnString emailError = RxnString(null);

  // Function to register user and send verification email
  void registerUser(String username, String email, String password) async {
    try {
      // Pass the username as the third argument
      await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password, username);
      
      // If registration is successful, redirect to a verification page or similar
      // Optionally, you can also send a verification email here
    } catch (e) {
      // Display the error message to the user
      Get.snackbar(
        'Error',
        e.toString(),
        mainButton: TextButton(
          onPressed: () {
            Get.to(SignUpPage()); // Redirect to signup page when user clicks the button
          },
          child: Text('Go to Login'),
        ),
      );
    }
  }

  // Store the data 
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  // Username validation
  void validateUsername(String value) {
    RegExp usernameRegEx = RegExp(r'^[a-zA-Z0-9]+$');
    if (!usernameRegEx.hasMatch(value)) {
      usernameError.value = "Username must be alphanumeric!";
    } else {
      usernameError.value = null;
    }
  }

  // Password validation
  void validatePassword(String value) {
    if (value.length < 6) {
      passwordError.value = "Password must be at least 6 characters!";
    } else {
      passwordError.value = null;
    }
  }

  // Email validation
  void validateEmail(String value) {
    RegExp emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegEx.hasMatch(value)) {
      emailError.value = "Enter a valid email!";
    } else {
      emailError.value = null;
    }
  }

  // Clean up controllers to prevent memory leaks
  @override
  void onClose() {
    username.dispose();
    password.dispose();
    email.dispose();
    super.onClose();
  }

  // Check if all validations are passed
  bool get isValid {
    return usernameError.value == null &&
        passwordError.value == null &&
        emailError.value == null;
  }
}
