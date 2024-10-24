
import 'package:chemlab_flutter_project/Repository/User_repository.dart';
import 'package:chemlab_flutter_project/model/user_model.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB3E5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FutureBuilder<UserModel?>(
            future: _fetchUserData(), // Fetch user data from Firestore
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No user data found.'));
              }

              // Get user data from Firestore
              UserModel user = snapshot.data!;
              String username = user.username;
              String email = user.email;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Your Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfileTextField(
                    hintText: username,
                    icon: Icons.person,
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  ProfileTextField(
                    hintText: '********', // You may want to handle passwords securely
                    icon: Icons.visibility,
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  ProfileTextField(
                    hintText: email,
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2FA0B9),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      // Log out button functionality
                      await _auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<UserModel?> _fetchUserData() async {
    String email = _auth.currentUser!.email!; // Get current user's email
    return await _userRepository.getUserByEmail(email); // Fetch user data by email
  }
}

class ProfileTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  ProfileTextField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 104, 181, 198),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        obscureText: obscureText,
        readOnly: true, // Make the field read-only since it's user data
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }
}
