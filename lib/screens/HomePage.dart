import 'package:flutter/material.dart';
// import 'package:main_flutter_project/screens/AndroidLarge3.dart';
// import 'package:main_flutter_project/screens/SignUpPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // This removes the debug banner
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 139, 205, 220), // Main background color
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/chem3.png', // Image path
                  width: 440, // Adjust the width if needed
                  height: 400, // Adjust the height if needed
                  fit: BoxFit.contain, // Ensures the image fits inside
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to Chem4u',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
               ElevatedButton(
  onPressed: () {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LoginPage(), // Replace with your next page widget
    //   ),
    // );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 124, 177, 189), // Button background color
    foregroundColor: Colors.black, // Text color
  ),
  child: Text(
    'Log in',
    style: TextStyle(
      fontWeight: FontWeight.bold, // Make the text bold
      color: Colors.black, // Ensure the text color is white
    ),
  ),
),

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SignUpPage(), // Replace with your next page widget
                    //   ),
                    // );
                  },
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 124, 177, 189),
                    foregroundColor: Colors.black,
                     // Button color
                  ),
                  child: Text('Sign up',style:TextStyle( fontWeight: FontWeight.bold, // Make the text bold
      color: Colors.black),),
                 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
