import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      home: SignUpPage(),
    );
  }
}
