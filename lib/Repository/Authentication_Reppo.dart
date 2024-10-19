import 'package:chemlab_flutter_project/EmailVerificationPage.dart';
import 'package:chemlab_flutter_project/Repository/exception/Signup_Email_password_failure.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
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
      // Redirect to email verification page if email is not verified
      if (!user.emailVerified) {
        Get.offAll(() => EmailVerificationPage());
      } else {
        Get.offAll(() => LoginPage());
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Send verification email after user creation
      await sendEmailVerification();
      
      // Optionally, redirect to email verification page
      Get.offAll(() => EmailVerificationPage());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      throw ex;
    } catch (e) {
      print('An unknown error occurred: $e');
      throw SignupEmailPasswordFailure();
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
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user != null && !user.emailVerified) {
        Get.snackbar('Email not verified', 'Please verify your email before logging in.');
        await _auth.signOut(); // Immediately sign the user out if email is not verified
      } else {
        Get.offAll(() => MainPage()); // Allow login if email is verified
      }
    } catch (e) {
      print('Error signing in: $e');
      Get.snackbar('Login Error', 'Failed to log in. Please check your credentials.');
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
