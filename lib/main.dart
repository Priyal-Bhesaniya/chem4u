import 'package:chemlab_flutter_project/Controller/Signup_page_controller.dart';
import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/Repository/User_repository.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase with the platform-specific options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Initialize the repositories and controllers
    Get.put<AuthenticationRepository>(AuthenticationRepository());
    Get.put<UserRepository>(UserRepository.instance);
    // Use lazyPut for the SignupPageController
    Get.lazyPut<SignupPageController>(() => SignupPageController());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Run the app after Firebase initialization
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      home: LoadingPage(),
    );
  }
}
