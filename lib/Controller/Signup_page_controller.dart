import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  // Singleton instance
  static SignupPageController get instance => Get.find();

  // TextEditingControllers
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();

  // Error messages for validation (RxnString allows null values)
  RxnString usernameError = RxnString(null);
  RxnString passwordError = RxnString(null);
  RxnString emailError = RxnString(null);
  RxnString mobileError = RxnString(null);

  get phoneNo => null;

  // Function to register user
  Future<void> registerUser() async {
    // Validate inputs
    validateEmail(email.text.trim());
    validatePassword(password.text.trim());
    validateUsername(username.text.trim());
    validateMobile(mobile.text.trim());

    // Only proceed if all validations pass
    if (isValid) {
      try {
        // Use AuthenticationRepository to register the user
        await AuthenticationRepository.instance.createUserWithEmailAndPassword(
          email.text.trim(),
          password.text.trim(),
        );
      } catch (e) {
        // Handle registration errors
        Get.snackbar(
          "Registration Error",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } else {
      // Show validation error if not valid
      Get.snackbar(
        "Validation Error",
        "Please correct the errors in the form.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
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

  // Mobile validation



void validateMobile(String value) {
  if (value.isEmpty) {
    mobileError.value = 'Mobile number is required';
  } else if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
    mobileError.value = 'Enter a valid 10-digit mobile number';
  } else {
    mobileError.value = null; // Clear error if valid
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
    mobile.dispose(); // Ensure to dispose mobile controller
    super.onClose();
  }

  // Check if all validations are passed
  bool get isValid {
    return usernameError.value == null &&
        passwordError.value == null &&
        emailError.value == null &&
        mobileError.value == null; // Include mobile error check here
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
