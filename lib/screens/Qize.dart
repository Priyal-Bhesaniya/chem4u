import 'package:chemlab_flutter_project/screens/ProfilePage.dart';
import 'package:flutter/material.dart';

class QuizePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/quiz.png"), // Add your background image
              ),
            ),
          ),
          SizedBox(height: 30),

          // Experiment buttons with navigation
          buildExperimentButton(context, "Quiz 1", () {
            // Navigate to Experiment 1 page
            print("Navigate to Experiment 1"); // Placeholder action
          }),
          SizedBox(height: 5),
          buildExperimentButton(context, "Quiz 2", () {
            // Navigate to Experiment 2 page
            print("Navigate to Experiment 2"); // Placeholder action
          }),
          SizedBox(height: 5),
          buildExperimentButton(context, "Quiz 3", () {
            // Navigate to Experiment 3 page
            print("Navigate to Experiment 3"); // Placeholder action
          }),
          SizedBox(height: 5),
          buildExperimentButton(context, "Quiz 4", () {
            // Navigate to Experiment 4 page
            print("Navigate to Experiment 4"); // Placeholder action
          }),
          SizedBox(height: 5),
          buildExperimentButton(context, "Quiz 5", () {
            // Navigate to Experiment 5 page
            print("Navigate to Experiment 5"); // Placeholder action
          }),
          SizedBox(height: 5),
          buildExperimentButton(context, "Quiz 6", () {
            // Navigate to Experiment 6 page
            print("Navigate to Experiment 6"); // Placeholder action
          }),
        ],
      ),
    );
  }

  // Helper method to create experiment buttons with navigation
  Widget buildExperimentButton(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 104, 181, 198),
        ),
        margin: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
