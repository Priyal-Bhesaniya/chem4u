import 'package:chemlab_flutter_project/EmailVerificationPage.dart';

import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';

import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Initialize Firestore
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoadingPage());
    } else {
      if (!user.emailVerified) {
        Get.offAll(() => EmailVerificationPage());
      } else {
        Get.offAll(() => LoginPage()); // Redirect to MainPage if email is verified
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password, String username) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Save user information in Firestore without storing the password
      await _firestore.collection('users').doc(email).set({
        'username': username,
        'email': email,
      });
      
      // Send verification email
      await sendEmailVerification();
      Get.offAll(() => EmailVerificationPage());
    } on FirebaseAuthException catch (e) {
      // Handle sign up errors
      throw Exception("Sign up failed: ${e.message}");
    } catch (e) {
      throw Exception("An unknown error occurred: $e");
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar('Verification Email Sent', 'Please check your email to verify your account.');
      }
    } catch (e) {
      print('Error sending email verification: $e');
      Get.snackbar('Error', 'Could not send verification email.');
    }
  }

Future<void> signInWithEmailAndPassword(String email, String password) async {
  try {
    // Log the email and password being used for sign-in
    print("Attempting to sign in with email: $email");

    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;

    if (user != null) {
      // Fetch the user data from Firestore
      UserModel? userModel = await getUserByEmail(email);
      if (userModel == null) {
        throw FirebaseAuthException(code: 'user-not-found', message: 'User not found in Firestore.');
      }

      if (!user.emailVerified) {
        Get.snackbar('Email not verified', 'Please verify your email before logging in.');
        await _auth.signOut(); // Sign out if email is not verified
        throw FirebaseAuthException(code: 'email-not-verified', message: 'Please verify your email.');
      }
    }
  } on FirebaseAuthException catch (e) {
    print('Firebase Auth Error: ${e.code} - ${e.message}'); // Log the error
    throw e; // Rethrow the exception to be caught in the LoginPage
  } catch (e) {
    print('Unexpected Error: $e'); // Log unexpected errors
    throw Exception("An unknown error occurred: $e");
  }
}





   Future<UserModel?> getUserByEmail(String email) async {
    var doc = await _firestore.collection('users').doc(email).get();
    if (doc.exists) {
      var data = doc.data();
      return UserModel(
        username: data!['username'],
        email: data['email'], password: '',
        // Avoid using plain passwords
      );
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
