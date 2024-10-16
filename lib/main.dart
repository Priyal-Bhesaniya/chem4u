import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package
import 'package:flutter/material.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart'; // Adjust the import path for SignUpPage

void main() async {
  // Ensure widgets are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp().then((_) {
    print("Firebase initialized");
  }).catchError((e) {
    print("Firebase initialization error: $e");
  });

  // Run your app after Firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      home: SignUpPage(), // Your SignUpPage as the home screen
    );
  }
}
