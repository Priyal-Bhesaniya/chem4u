import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart'; // Make sure you import LoginPage

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  bool _loading = true; // To show loading state while fetching user data
  bool _error = false; // To track if an error occurs
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore based on the logged-in user's email
  Future<void> _fetchUserData() async {
    try {
      _user = _auth.currentUser!; // Get current logged-in user
      if (_user == null) {
        setState(() {
          _error = true;
          _loading = false;
        });
        return;
      }

      String email = _user.email!.toLowerCase(); // Use the email to fetch data

      print("Fetching data for email: $email");

      // Fetch the document from Firestore using the email as the document ID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .get();

      if (userDoc.exists) {
        // User data exists in the database, let's fetch it
        setState(() {
          _username = userDoc['username'] ?? 'No username found';
          _email = userDoc['email'] ?? 'No email found';
          _loading = false; // Stop loading once data is fetched
        });
        print("User data fetched: $_username, $_email");
      } else {
        setState(() {
          _error = true; // Set error state if no data found
          _loading = false; // Stop loading
        });
        print("No user found in Firestore with email: $email");
      }
    } catch (e) {
      setState(() {
        _loading = false; // Stop loading if an error occurs
        _error = true; // Set error state
      });
      print("Error fetching user data: $e");
    }
  }

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
          child: _loading
              ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
              : _error
                  ? Center(child: Text('Error fetching user data. Please try again later.')) // Show error message
                  : Column(
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
                        TextField(
                          controller: TextEditingController(text: _username),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                            filled: true,
                            fillColor: Color.fromARGB(255, 104, 181, 198),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: TextEditingController(text: '********'),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.visibility, color: Colors.black),
                            filled: true,
                            fillColor: Color.fromARGB(255, 104, 181, 198),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: TextEditingController(text: _email),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                            filled: true,
                            fillColor: Color.fromARGB(255, 104, 181, 198),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          readOnly: true,
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
                            await _auth.signOut(); // Sign out the user
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(), // Navigate to LoginPage
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
                    ),
        ),
      ),
    );
  }
}
