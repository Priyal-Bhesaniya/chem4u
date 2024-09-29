import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Implement your navigation logic here (e.g., Navigator.pop(context))
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              // Replace with your actual profile image or a placeholder
              backgroundImage: AssetImage('assets/your_profile_image.png'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Priyal Bhesaniya',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            Text(
              'pbhesaniya373@rku.ac.in',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement your logout logic here (e.g., Navigator.pushReplacementNamed(context, '/login'))
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}