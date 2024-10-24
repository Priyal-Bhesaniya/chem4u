import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/screens/MainPage.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Import your AuthenticationRepository
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(); // Change to _emailController
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError; // Change to _emailError
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    // Add listeners to controllers for real-time validation
    _emailController.addListener(() {
      _validateEmail(); // Change to _validateEmail
    });

    _passwordController.addListener(() {
      _validatePassword();
    });
  }

  // Validate email in real-time
  void _validateEmail() {
    String email = _emailController.text;
    RegExp emailRegEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'); // Email regex
    
    setState(() {
      if (!emailRegEx.hasMatch(email)) {
        _emailError = "Invalid email format!";
      } else {
        _emailError = null;
      }
    });
  }

  // Validate password in real-time
  void _validatePassword() {
    String password = _passwordController.text;
    RegExp passwordRegEx = RegExp(r'^.{6,}$'); // Password must be at least 6 characters

    setState(() {
      if (!passwordRegEx.hasMatch(password)) {
        _passwordError = "Password must be at least 6 characters!";
      } else {
        _passwordError = null;
      }
    });
  }

  void _validateInput() async {
    // Final validation when login button is pressed
    _validateEmail(); // Change to _validateEmail
    _validatePassword();

    // Proceed only if there are no errors
    if (_emailError == null && _passwordError == null) {
      try {
        // Attempt to sign in the user
        await AuthenticationRepository.instance.signInWithEmailAndPassword(
          _emailController.text, // Change to _emailController.text
          _passwordController.text,
        );

        // If login is successful, navigate to MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } catch (e) {
        // Handle any errors that occurred during login
        Get.snackbar('Login Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
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
                    image: AssetImage('assets/images/Login_page.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // 'Log in' Text
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
                  controller: _emailController, // Change to _emailController
                  decoration: InputDecoration(
                    hintText: 'Email', // Change to Email
                    errorText: _emailError, // Display error message
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: _emailError == null ? Colors.transparent : Colors.red),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    prefixIcon: Icon(Icons.email), // Change icon to email icon
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
                    errorText: _passwordError, // Display error message
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
    _emailController.dispose(); // Change to _emailController.dispose()
    _passwordController.dispose();
    super.dispose();
  }
}
