

import 'package:chemlab_flutter_project/Repository/exception/Signup_Email_password_failure.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';

import 'package:chemlab_flutter_project/screens/Otp_varification.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    // Navigate to the appropriate screen based on user state
    if (user == null) {
      Get.offAll(() => LoadingPage());
    } else {
      Get.offAll(() => SignUpPage());
    }
  }

 Future<void> phoneAuthentication(String phoneNo) async {
  // Ensure the phone number is in the correct format
  final formattedPhoneNo = phoneNo.startsWith('+') ? phoneNo : '+91$phoneNo';

  await _auth.verifyPhoneNumber(
    phoneNumber: formattedPhoneNo, // Use the formatted phone number
    verificationCompleted: (credential) async {
      await _auth.signInWithCredential(credential);
    },
    verificationFailed: (e) {
      if (e.code == 'invalid-phone-number') {
        Get.snackbar('Error', 'The provided phone number is not valid');
      } else {
        Get.snackbar('Error', 'An error occurred during phone verification');
      }
    },
    codeSent: (verificationId, resendToken) {
      this.verificationId.value = verificationId;
    },
    codeAutoRetrievalTimeout: (verificationId) {
      this.verificationId.value = verificationId;
    },
  );
}


  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: this.verificationId.value,
        smsCode: otp,
      ),
    );
    return credentials.user != null;
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Successfully created the user
        Get.offAll(() => OtpVerification());
      } else {
        // Navigate to loading page as fallback
        Get.to(() => LoadingPage());
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      Get.showSnackbar(GetSnackBar(message: 'Firebase error: ${ex.message}'));
      throw ex;
    } catch (e) {
      const ex = SignupEmailPasswordFailure();
      print('An unknown error occurred: ${e.toString()}');
      Get.showSnackbar(GetSnackBar(message: 'An unknown error occurred: ${e.toString()}'));
      throw ex;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Error signing in: ${e.message}');
    } catch (e) {
      throw Exception('Error signing in: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
