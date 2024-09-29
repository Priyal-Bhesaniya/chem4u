import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';


class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),  // Light blue background
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
                  backgroundImage: AssetImage('assets/images/Login_page.png'),  // Ensure you have the image in your assets
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

                // Username input field
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: 'Username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Password input field
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      hintText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                // Email input field
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 104, 181, 198),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintText: 'E-mail',
                      
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Sign-up button
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-up logic
 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginPage(), // Replace with your next page widget
                  ),
                );

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    backgroundColor: Color(0xFF2FA0B9),  // Matching button color
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
