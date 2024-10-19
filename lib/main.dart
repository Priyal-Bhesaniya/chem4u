import 'package:chemlab_flutter_project/Controller/Signup_page_controller.dart';
import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/screens/Otp_varification.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
 // Import your OtpVerification page
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase and register controllers lazily
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      Get.put(AuthenticationRepository());
      // Use lazyPut for the SignupPageController
      Get.lazyPut<SignupPageController>(() => SignupPageController());
    });
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // Run your app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/SignUpPage', // Set initial route to SignUpPage
      getPages: [
        GetPage(name: '/SignUpPage', page: () => SignUpPage()), // Define SignUpPage route
        GetPage(name: '/OtpVerification', page: () => OtpVerification()), // Define OtpVerification route
      ],
    );
  }
}
