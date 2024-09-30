import 'package:chemlab_flutter_project/screens/LoginPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB3E5FC), // Light blue background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
             Navigator.pop(context);// Back button functionality
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              hintText: 'Priyal Bhesaniya',
              icon: Icons.person,
            ),
            SizedBox(height: 10),
            ProfileTextField(
              hintText: '********',
              icon: Icons.visibility,
              obscureText: true,
            ),
            SizedBox(height: 10),
            ProfileTextField(
              hintText: 'pbhesaniya373@rku.ac.in',
              icon: Icons.email,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2FA0B9), // Button color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  
                  
                ),
              ),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginPage(),
                  ),);
                // Log out button functionality
                
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
        ),
      ),
    );
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
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }
}
