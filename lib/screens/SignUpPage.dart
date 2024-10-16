import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Firebase Auth
import 'package:firebase_database/firebase_database.dart';  // Firebase Realtime Database
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _usernameError;
  String? _passwordError;
  String? _emailError;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();  // Realtime Database reference

  @override
  void initState() {
    super.initState();

    // Add listeners for real-time validation
    _usernameController.addListener(() {
      _validateUsername();
    });

    _passwordController.addListener(() {
      _validatePassword();
    });

    _emailController.addListener(() {
      _validateEmail();
    });
  }

  // Username validation
  void _validateUsername() {
    String username = _usernameController.text;
    RegExp usernameRegEx = RegExp(r'^[a-zA-Z0-9]+$');
    
    setState(() {
      if (!usernameRegEx.hasMatch(username)) {
        _usernameError = "Username must be alphanumeric!";
      } else {
        _usernameError = null;
      }
    });
  }

  // Password validation
  void _validatePassword() {
    String password = _passwordController.text;
    RegExp passwordRegEx = RegExp(r'^.{6,}$'); // Minimum 6 characters

    setState(() {
      if (!passwordRegEx.hasMatch(password)) {
        _passwordError = "Password must be at least 6 characters!";
      } else {
        _passwordError = null;
      }
    });
  }

  // Email validation
  void _validateEmail() {
    String email = _emailController.text;
    RegExp emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Simple email validation

    setState(() {
      if (!emailRegEx.hasMatch(email)) {
        _emailError = "Enter a valid email!";
      } else {
        _emailError = null;
      }
    });
  }

  Future<void> _signUp() async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      
      User? user = userCredential.user;
      
      if (user != null) {
        // Store additional user info (username) in Realtime Database
        await _database.child("users").child(user.uid).set({
          'username': _usernameController.text,
          'email': _emailController.text,
        });

        // Navigate to login page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    } catch (e) {
      print('Sign-up error: $e');
      // Display error message if sign-up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: ${e.toString()}')),
      );
    }
  }

  void _validateInput() {
    // Final validation when sign-up button is pressed
    _validateUsername();
    _validatePassword();
    _validateEmail();

    // If all inputs are valid, proceed with the sign-up
    if (_usernameError == null && _passwordError == null && _emailError == null) {
      _signUp();  // Call the sign-up function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scientist image at the top
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/Login_page.png'),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 30),

                // "Sign Up" text
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // Username input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: 'Username',
                      errorText: _usernameError,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Password input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      hintText: 'Password',
                      errorText: _passwordError,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Email input field with validation
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintText: 'E-mail',
                      errorText: _emailError,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Sign-up button
                ElevatedButton(
                  onPressed: _validateInput,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    backgroundColor: Color(0xFF2FA0B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
