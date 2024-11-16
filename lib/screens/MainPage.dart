import 'package:chemlab_flutter_project/screens/ExperimentPage.dart';
import 'package:chemlab_flutter_project/screens/Moduals.dart';
import 'package:chemlab_flutter_project/screens/NotesPage.dart';
import 'package:chemlab_flutter_project/screens/ProfilePage.dart';
import 'package:chemlab_flutter_project/screens/Qize.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 139, 205, 220),  // Background color
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
                color: const Color.fromARGB(255, 104, 181, 198),
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
                    builder: (context) => ProfilePage(),  // Navigate to profile page
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.25, // 25% of screen height
              child: Lottie.asset('assets/animations/Mainpage1.json'), // Ensure correct animation path
            ),
            SizedBox(height: screenHeight * 0.03), // 3% of screen height

            // First row with Quiz and Modulas buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(
                  context,
                  'Quiz',
                  'assets/images/quiz.png',
                  screenHeight,
                  screenWidth,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizePage()),
                  ),
                ),
                buildFeatureButton(
                  context,
                  'Modulas',
                  'assets/images/modulas.png',
                  screenHeight,
                  screenWidth,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModualsPage()),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height

            // Second row with Experiments and Notes buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFeatureButton(
                  context,
                  'Experiments',
                  'assets/images/experiments.png',
                  screenHeight,
                  screenWidth,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExperimentPage()),
                  ),
                ),
                buildFeatureButton(
                  context,
                  'Notes',
                  'assets/images/notes.png',
                  screenHeight,
                  screenWidth,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notespage()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a feature button with image and label
  Widget buildFeatureButton(BuildContext context, String label, String imagePath, double screenHeight, double screenWidth, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(
            imagePath,
            height: screenHeight * 0.1, // 10% of screen height
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // 1% of screen height
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.04, // Dynamic font size
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
