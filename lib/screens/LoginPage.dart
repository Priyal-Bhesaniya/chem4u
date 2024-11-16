import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get for snackbar

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    // Real-time validation listeners
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  // Validate email format
  void _validateEmail() {
    String email = _emailController.text;
    RegExp emailRegEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    setState(() {
      _emailError = !emailRegEx.hasMatch(email) ? "Invalid email format!" : null;
    });
  }

  // Validate password length
  void _validatePassword() {
    String password = _passwordController.text;
    setState(() {
      _passwordError = password.length < 6 ? "Password must be at least 6 characters!" : null;
    });
  }

  // Handle final input validation and login
  void _validateInput() async {
    _validateEmail();
    _validatePassword();

    if (_emailError == null && _passwordError == null) {
      try {
        // Attempt to retrieve user data from Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(_emailController.text)
            .get();

        if (userDoc.exists) {
          String dbPassword = userDoc.data()?['password'] ?? '';

          if (dbPassword == _passwordController.text) {
            // Credentials matched, update or store user data
            final userData = {
              'email': _emailController.text,
              'lastLogin': FieldValue.serverTimestamp(), // Record login timestamp
            };

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(_emailController.text)
                .update(userData);

            // Navigate to MainPage
            Get.offAll(() => MainPage());
          } else {
            // Incorrect password
            Get.snackbar(
              'Login Failed', 'Incorrect password. Please try again.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
          }
        } else {
          // User not found
          Get.snackbar(
            'Login Failed', 'No user found with this email.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Login Error', 'Failed to log in: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top image
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Login_page.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Log in',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              // Email TextField
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 104, 181, 198),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: _emailError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: _emailError == null ? Colors.transparent : Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Password TextField
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 104, 181, 198),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: _passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: _passwordError == null ? Colors.transparent : Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Login Button
              Container(
                width: 290,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateInput,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2FA0B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Bottom Text with clickable "Create now"
              RichText(
                text: TextSpan(
                  text: 'Do you have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
