import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  bool isVerified = false;
  bool isLoading = false;

  @override
  void initState() {
    _user = _auth.currentUser;
    if (_user != null && _user!.emailVerified) {
      setState(() {
        isVerified = true;
      });
    }
    super.initState();
  }

  // Method to check if email is verified
  Future<void> checkEmailVerified() async {
    await _user?.reload();  // Refresh the user's data
    _user = _auth.currentUser;
    if (_user != null && _user!.emailVerified) {
      setState(() {
        isVerified = true;
      });
      Get.offAll(() => LoginPage()); // Redirect to login page once verified
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : isVerified
                ? Text('Email is verified! Redirecting...')
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Please verify your email address',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await checkEmailVerified();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text('I have verified my email'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A verification email has been sent to ${_user?.email}. Please check your inbox.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
