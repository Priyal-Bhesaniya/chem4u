import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class DragAndDropQuizPage extends StatefulWidget {
  @override
  _DragAndDropQuizPageState createState() => _DragAndDropQuizPageState();
}

class _DragAndDropQuizPageState extends State<DragAndDropQuizPage> {
  List<String> draggableItems = ['H2O', 'NaCl', 'CO2', 'O2', 'HCl', 'CH4'];
  List<String> targetNames = ['Water', 'Sodium Chloride', 'Carbon Dioxide', 'Oxygen'];
  List<String> correctAnswers = ['H2O', 'NaCl', 'CO2', 'O2'];
  List<String> answers = ['', '', '', ''];
  int score = 0;
  String feedback = '';
  bool quizCompleted = false;

  // Check if the answer is correct and update the score and feedback
  void _checkAnswer(int index, String droppedItem) {
    setState(() {
      if (droppedItem == correctAnswers[index]) {
        score++;
        feedback = 'Correct!';
      } else {
        feedback = 'Incorrect. Try again!';
      }

      // Check if all answers are filled
      if (answers.every((answer) => answer.isNotEmpty)) {
        quizCompleted = true;
      }
    });
  }

  // Save the user's score to Firestore
  Future<void> _saveScoreToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('quizzes').doc(user.email).set({
          'email': user.email,
          'quizName': 'Drag and Drop Quiz 1',
          'score': score,
          'totalQuestions': targetNames.length,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("Quiz score saved successfully!");
      } catch (e) {
        print("Error saving score to Firestore: $e");
      }
    } else {
      print("No user is currently logged in.");
    }
  }

  // Handle submission of the quiz
  void _submitQuiz() async {
    if (!quizCompleted) {
      setState(() {
        feedback = "Please complete the quiz before submitting.";
      });
      return;
    }

    // Save score and navigate to animation
    await _saveScoreToFirestore();
    _showLottieAnimation();
  }

  // Navigate to Lottie animation page
  void _showLottieAnimation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LottieAnimationPage(score: score, total: targetNames.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz 1: Drag and Drop'),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Match the correct chemical formulas with their names',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Score and feedback
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                feedback,
                style: TextStyle(fontSize: 16, color: feedback == 'Correct!' ? Colors.green : Colors.red),
              ),
              SizedBox(height: 30),

              // Draggable items and drop targets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Left side: Draggable items
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(draggableItems.length, (index) {
                      return Draggable<String>(
                        data: draggableItems[index],
                        child: DraggableItemBox(draggableItems[index]),
                        feedback: Material(
                          child: DraggableItemBox(draggableItems[index], isFeedback: true),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: DraggableItemBox(draggableItems[index]),
                        ),
                      );
                    }),
                  ),

                  // Right side: Drop targets
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(targetNames.length, (index) {
                      return DragTarget<String>(
                        onAccept: (receivedItem) {
                          setState(() {
                            answers[index] = receivedItem;
                            _checkAnswer(index, receivedItem);
                          });
                        },
                        builder: (context, acceptedItems, rejectedItems) {
                          return TargetItemBox(targetNames[index], answers[index]);
                        },
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Submit button
              ElevatedButton(
                onPressed: _submitQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Submit Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for draggable items
class DraggableItemBox extends StatelessWidget {
  final String item;
  final bool isFeedback;

  DraggableItemBox(this.item, {this.isFeedback = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isFeedback ? Colors.blueAccent : Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          item,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Widget for drop target items with target name and answer
class TargetItemBox extends StatelessWidget {
  final String targetName;
  final String answer;

  TargetItemBox(this.targetName, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: answer.isEmpty ? Colors.grey[300] : Colors.greenAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            targetName,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Text(
            answer.isEmpty ? 'Drop Here' : answer,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Full-screen Lottie animation page
class LottieAnimationPage extends StatelessWidget {
  final int score;
  final int total;

  LottieAnimationPage({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    // Start a timer to redirect after 4 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.popUntil(context, (route) => route.isFirst);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/pop2.json', // Replace with your Lottie animation file
              width: MediaQuery.of(context).size.width, // Full width
              height: MediaQuery.of(context).size.height * 0.5, // Half height
              repeat: false,
            ),
            SizedBox(height: 20),
            Text(
              'Final Score: $score/$total',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Return to Home'),
            )
          ],
        ),
      ),
    );
  }
}
