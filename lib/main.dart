// Import Firebase core package
import 'package:flutter/material.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart'; // Adjust the import path for SignUpPage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
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
