import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  // Singleton instance
  static SignupPageController get instance => Get.find(); // This works after Get.put() is called

  // TextEditingControllers
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final mobileNumber = TextEditingController();  // New controller for mobile number

  // Error messages for validation (RxnString allows null values)
  RxnString usernameError = RxnString(null);
  RxnString passwordError = RxnString(null);
  RxnString emailError = RxnString(null);
  RxnString mobileNumberError = RxnString(null);  // New error message for mobile number

  // Function to register user
 void registerUser(String email, String password, String mobileNumber) async {
  try {
    // Use AuthenticationRepository to register the user
    await AuthenticationRepository.instance.creatUserWithEmailAndPassword(email, password, mobileNumber);
    // Navigate to the next page or show a success message if needed
  } catch (error) {
    // Handle the error and show a snackbar with the error message
    Get.showSnackbar(GetSnackBar(message: error.toString(), duration: Duration(seconds: 2)));
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

  // Email validation
  void validateEmail(String value) {
    RegExp emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegEx.hasMatch(value)) {
      emailError.value = "Enter a valid email!";
    } else {
      emailError.value = null;
    }
  }

  // Mobile number validation
  void validateMobileNumber(String value) {
    RegExp mobileRegEx = RegExp(r'^\d{10}$'); // Assuming 10-digit mobile numbers
    if (!mobileRegEx.hasMatch(value)) {
      mobileNumberError.value = "Enter a valid 10-digit mobile number!";
    } else {
      mobileNumberError.value = null;
    }
  }

  // Clean up controllers to prevent memory leaks
  @override
  void onClose() {
    username.dispose();
    password.dispose();
    email.dispose();
    mobileNumber.dispose();  // Dispose the mobile number controller
    super.onClose();
  }

  // Check if all validations are passed
  bool get isValid {
    return usernameError.value == null &&
        passwordError.value == null &&
        emailError.value == null &&
        mobileNumberError.value == null;  // Ensure mobile number validation is passed
  }
}
