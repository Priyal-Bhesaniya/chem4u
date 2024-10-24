import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/Repository/User_repository.dart';
import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  // Singleton instance
  static SignupPageController get instance => Get.find(); // Works after Get.put() is called

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
  void registerUser(String email, String password, String username) async {
    try {
      // Validate the fields before attempting to register
      validateUsername(username);
      validateEmail(email);
      validatePassword(password);

      if (!isValid) {
        Get.snackbar('Error', 'Please correct the errors in the form.');
        return;
      }

      // Register user using Firebase Authentication
      await AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password, username);

      // If successful, create a user entry in Firestore
      final user = UserModel(
        username: username,
        email: email,
        password: password, // You may want to encrypt or avoid storing the password directly
      );
      await createUser(user);

      Get.snackbar(
        'Success',
        'Registration successful! A verification email has been sent.',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Redirect user to a verification page, login page, or next step
    } catch (e) {
      // Display the error message
      Get.snackbar(
        'Error',
        'Failed to sign up: ${e.toString()}',
        mainButton: TextButton(
          onPressed: () {
            Get.to(SignUpPage()); // Redirect to the signup page
          },
          child: Text('Try Again'),
        ),
      );
    }
  }

  // Store the user data in Firestore
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  // Username validation
  void validateUsername(String value) {
    RegExp usernameRegEx = RegExp(r'^[a-zA-Z0-9]+$');
    if (value.isEmpty) {
      usernameError.value = "Username cannot be empty!";
    } else if (!usernameRegEx.hasMatch(value)) {
      usernameError.value = "Username must be alphanumeric!";
    } else {
      usernameError.value = null; // Clear error if valid
    }
  }

  // Password validation
  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = "Password cannot be empty!";
    } else if (value.length < 6) {
      passwordError.value = "Password must be at least 6 characters!";
    } else {
      passwordError.value = null; // Clear error if valid
    }
  }

  // Email validation
  void validateEmail(String value) {
    RegExp emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) {
      emailError.value = "Email cannot be empty!";
    } else if (!emailRegEx.hasMatch(value)) {
      emailError.value = "Enter a valid email!";
    } else {
      emailError.value = null; // Clear error if valid
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
