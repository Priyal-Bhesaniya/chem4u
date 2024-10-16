import 'package:chemlab_flutter_project/Repository/exception/Signup_Email_password_failure.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get Instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser ;

 @override
 void onReady(){
  firebaseUser = Rx<User?>(_auth.currentUser);
  firebaseUser.bindStream(_auth.userChanges());
  ever (firebaseUser,_setInitialScreen); 
 }
  
_setInitialScreen(User? user){
  user == null ? Get.offAll (()=> LoadingPage()) : Get.offAll(()=> MainPage());
}
  

Future<void> creatUserWithEmailAndPassword(String email, String password)
  
async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    firebaseUser.value != null ? Get.offAll(()=>MainPage()):Get.to(()=>LoadingPage());
  }
  on FirebaseAuthException catch(e){
    final ex = SignupEmailPasswordFailure.code(e.code);
    print('Firebase Auth Exception - ${ex.message}');
    throw ex;
    }
    catch (_) {
    const ex = SignupEmailPasswordFailure();
    print('An error occurred: ${ex.message}');
    throw ex;
  }
  
}


Future<void> signInWithEmailAndPassword(String email, String password) async {
try{
  await _auth.signInWithEmailAndPassword(email: email, password: password);
  } catch (error) {
    throw Exception('Error signing in: $error');
  
}
}
Future<void> logout() async => await _auth.signOut();

}