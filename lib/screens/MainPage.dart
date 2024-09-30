import 'package:chemlab_flutter_project/screens/ExperimentPage.dart';
import 'package:chemlab_flutter_project/screens/LoginPage.dart';

import 'package:chemlab_flutter_project/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define scaling factors for different screen sizes
// Text scale based on system settings

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),  // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight * 0.1, // 10% of screen height
              width: screenWidth * 0.6,   // 60% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 104, 181, 198),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  'Hi Priyal!',
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: screenWidth * 0.06,  // Dynamic font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ProfilePage(),  // Navigate to profile page
                  ),
                );
              },
              icon: Icon(
                Icons.person_outline, 
                color: Colors.black, 
                size: screenWidth * 0.08,  // Dynamic icon size based on screen width
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(  // Added to handle overflow on smaller screens
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation container
            Container(
              height: screenHeight * 0.25, // 25% of screen height
              child: Lottie.asset('assets/animations/Mainpage1.json'), // Ensure you have the correct animation path
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height

            // First row with buttons (Quiz, Modulas)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Quiz button
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle quiz button press
                      },
                      child: Image.asset(
                        'assets/images/quiz.png',  // Quiz image
                        height: screenHeight * 0.1, // 10% of screen height
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 1% of screen height
                    Text(
                      'Quiz', 
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,  // Dynamic font size
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Modulas button
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle modulas button press
                      },
                      child: Image.asset(
                        'assets/images/modulas.png',  // Modulas image
                        height: screenHeight * 0.1, // 10% of screen height
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 1% of screen height
                    Text(
                      'Modulas', 
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,  // Dynamic font size
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height

            // Second row with buttons (Experiments, Notes)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Experiments button
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ExperimentPage(),),);
                  //       // Handle experiments button press
                      },
                      child: Image.asset(
                        'assets/images/experiments.png',  // Experiments image
                        height: screenHeight * 0.1, // 10% of screen height
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 1% of screen height
                    Text(
                      'Experiments', 
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,  // Dynamic font size
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Notes button
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle notes button press
                      },
                      child: Image.asset(
                        'assets/images/notes.png',  // Notes image
                        height: screenHeight * 0.1, // 10% of screen height
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 1% of screen height
                    Text(
                      'Notes', 
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,  // Dynamic font size
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
