import 'package:flutter/material.dart';

class ExperimentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Media query to get screen size
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Experiment"),
        backgroundColor: Colors.lightBlue[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile or settings
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_chemistry.png"), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Image.asset(
              'assets/chemistry_icon.png', // Replace with your own image path
              height: screenHeight * 0.15,
              width: screenWidth * 0.3,
            ),
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              child: ListView(
                children: [
                  experimentButton("Experiment 1", screenHeight),
                  experimentButton("Experiment 2", screenHeight),
                  experimentButton("Experiment 3", screenHeight),
                  experimentButton("Experiment 4", screenHeight),
                  experimentButton("Experiment 5", screenHeight),
                  experimentButton("Experiment 6", screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget experimentButton(String text, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
         // Button color
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03, horizontal: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          // Add experiment navigation logic here
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black, // Text color
            fontSize: screenHeight * 0.025,
          ),
        ),
      ),
    );
  }
}
