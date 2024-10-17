import 'package:chemlab_flutter_project/Repository/exception/Signup_Email_password_failure.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore for storing additional user info
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => LoadingPage()) : Get.offAll(() => MainPage());
  }

  // Function to create a user with email, password, and store additional info like mobile number
  Future<void> creatUserWithEmailAndPassword(String email, String password, String mobile) async {
    try {
      // Create user with Firebase Auth
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data (mobile number) to Firestore
      if (firebaseUser.value != null) {
        await _firestore.collection('users').doc(firebaseUser.value!.uid).set({
          'email': email,
          'mobile': mobile,
        });

        // Navigate to MainPage after successful signup
        Get.offAll(() => MainPage());
      } else {
        Get.to(() => LoadingPage());
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific signup errors
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      throw ex;
    } catch (_) {
      // Handle other errors
      const ex = SignupEmailPasswordFailure();
      print('An error occurred: ${ex.message}');
      throw ex;
    }
  }

  // Sign-in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      throw Exception('Error signing in: $error');
    }
  }

  // Logout function
  Future<void> logout() async => await _auth.signOut();
}
