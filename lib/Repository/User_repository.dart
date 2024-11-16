import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find<UserRepository>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a new user in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.email.toLowerCase()).set(user.toJson());
      _showSnackbar("Success", "Your account has been created.", Colors.green);
    } catch (error) {
      _showSnackbar("Error", "Something went wrong: ${error.toString()}", Colors.red);
      print("Error creating user: $error");
    }
  }

  /// Retrieves a user from Firestore by email
  // Future<UserModel?> getUserByEmail(String email) async {
  //   try {
  //     String formattedEmail = email.toLowerCase(); // Ensure email is in lowercase
  //     print("Fetching user for email: $formattedEmail");

  //     DocumentSnapshot doc = await _db.collection("Users").doc(formattedEmail).get();
  //     if (doc.exists) {
  //       return UserModel.fromJson(doc.data() as Map<String, dynamic>);
  //     } else {
  //       _showSnackbar("Not Found", "No user found with this email.", Colors.yellow);
  //       return null;
  //     }
  //   } catch (error) {
  //     _showSnackbar("Error", "Something went wrong: ${error.toString()}", Colors.red);
  //     print("Error retrieving user: $error");
  //     return null;
  //   }
  // }

   Future<UserModel?> getUserByEmail(String email) async {
    try {
      String formattedEmail = email.toLowerCase(); // Ensure email is in lowercase
      print("Fetching user for email: $formattedEmail"); // Debugging log

      DocumentSnapshot doc = await _db.collection("Users").doc(formattedEmail).get();
      if (doc.exists) {
        print("User found for email: $formattedEmail"); // Debugging log
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print("No user found for email: $formattedEmail"); // Debugging log
        return null;
      }
    } catch (error) {
      print("Error retrieving user: $error"); // Debugging log
      return null;
    }
  }

  /// Saves a note for the specified user in Firestore
  Future<void> saveNoteForUser(String email, String noteContent) async {
    try {
      await _db
          .collection('Users')
          .doc(email.toLowerCase())  // Ensure email is in lowercase
          .collection('notes')
          .add({
        'content': noteContent,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      print("Error saving note for user $email: $error");
      throw error; // Rethrow error for handling in UI
    }
  }

  /// Helper method to show snackbars
  void _showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withOpacity(0.1),
      colorText: color,
    );
  }
}
