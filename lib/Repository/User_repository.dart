import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a new user in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.email).set(user.toJson());
      Get.snackbar(
        "Success",
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error creating user: $error");
    }
  }

  /// Retrieves a user from Firestore by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      DocumentSnapshot doc = await _db.collection("Users").doc(email).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        Get.snackbar(
          "Not Found",
          "No user found with this email.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.yellow.withOpacity(0.1),
          colorText: Colors.black,
        );
        return null;
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error retrieving user: $error");
      return null;
    }
  }
}
