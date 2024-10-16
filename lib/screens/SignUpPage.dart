import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _usernameError;
  String? _passwordError;
  String? _emailError;

  // Username validation
  void _validateUsername(String username) {
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
  void _validatePassword(String password) {
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
  void _validateEmail(String email) {
    RegExp emailRegEx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Simple email validation
    setState(() {
      if (!emailRegEx.hasMatch(email)) {
        _emailError = "Enter a valid email!";
      } else {
        _emailError = null;
      }
    });
  }

  void _validateInput(String username, String password, String email) {
    // Final validation when sign-up button is pressed
    _validateUsername(username);
    _validatePassword(password);
    _validateEmail(email);

    // If all inputs are valid, navigate to the login page
    if (_usernameError == null && _passwordError == null && _emailError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';
    String email = '';

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
                    onChanged: (value) {
                      username = value;
                      _validateUsername(username);
                    },
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
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                      _validatePassword(password);
                    },
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
                    onChanged: (value) {
                      email = value;
                      _validateEmail(email);
                    },
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
                  onPressed: () {
                    _validateInput(username, password, email);
                  },
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
}
