import 'dart:ffi';

import 'package:chemlab_flutter_project/Repository/exception/Signup_Email_password_failure.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:chemlab_flutter_project/screens/Otp_varification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var varificationId = ''.obs;

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
      Get.offAll(() => MainPage());
    }
  }
Future<void> phoneAuthentication(String phoneNo) async {
 await _auth.verifyPhoneNumber(
  phoneNumber: phoneNo,
  verificationCompleted: (credintial) async {
    await _auth.signInWithCredential(credintial);
  }, 
  verificationFailed: (e){
    if(e.code =='invalid phone number'){
      Get.snackbar('Error', 'The Provided phone number is not valid') ;
    }
    else 
    {
      Get.snackbar('Error', 'An error occurred during the phone verification process') ;
    }
  }, 
  codeSent: (varificationId,resendToken){
    this.varificationId.value = varificationId;
    
  }, 
  codeAutoRetrievalTimeout: (varificationId){
    this.varificationId.value = varificationId;

  }, );

}

Future<bool> varifyOTP (String otp) async{
  var credintials=  await _auth
  .signInWithCredential(PhoneAuthProvider.credential(verificationId:this.varificationId.value,smsCode: otp)); 
  return credintials.user !=null ? true : false;
}


  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if userCredential contains a valid user
      User? user = userCredential.user;

      if (user != null) {
        // Successfully created the user
        Get.offAll(() => OtpVerification());
      } else {
        // Navigate to loading page as fallback
        Get.to(() => LoadingPage());
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception - ${ex.message}');
      Get.showSnackbar(GetSnackBar(message: 'Firebase error: ${ex.message}'));
      throw ex; // Propagate the error
    } catch (e) {
      // Handle other errors
      const ex = SignupEmailPasswordFailure();
      print('An unknown error occurred: ${e.toString()}');
      Get.showSnackbar(GetSnackBar(message: 'An unknown error occurred: ${e.toString()}'));
      throw ex; // Propagate the error
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase sign-in errors
      throw Exception('Error signing in: ${e.message}');
    } catch (e) {
      // Handle other errors
      throw Exception('Error signing in: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
