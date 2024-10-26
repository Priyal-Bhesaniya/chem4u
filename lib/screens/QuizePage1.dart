import 'package:flutter/material.dart';
import 'package:chemlab_flutter_project/screens/ProfilePage.dart';

class QuizePage1 extends StatefulWidget {
  @override
  _QuizePage1State createState() => _QuizePage1State();
}

class _QuizePage1State extends State<QuizePage1> {
  int _score = 0;
  int _currentQuestionIndex = 0;
  String _feedback = '';
  String? _droppedAnswer;

  final List<Map<String, Object>> _questions = [
    {
      'question': "Drag the correct formula for Water:",
      'options': ["H2O", "CO2", "O2", "NaCl"],
      'answer': "H2O",
    },
    {
      'question': "Drag the symbol for Sodium:",
      'options': ["Na", "Cl", "O", "S"],
      'answer': "Na",
    },
    // Add more questions as needed
  ];

  void _checkAnswer() {
    String correctAnswer = _questions[_currentQuestionIndex]['answer'] as String;

    setState(() {
      if (_droppedAnswer == correctAnswer) {
        _score++;
        _feedback = "Correct!";
      } else {
        _feedback = "Incorrect. The correct answer is $correctAnswer.";
      }

      _droppedAnswer = null;

      // Move to the next question or show completion feedback
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _feedback += " Quiz Complete!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag-and-Drop Quiz"),
        backgroundColor: const Color.fromARGB(255, 104, 181, 198),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              height: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/quiz.png"),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Display quiz question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    _questions[_currentQuestionIndex]['question'] as String,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Answer Options as Draggable items
                  Wrap(
                    spacing: 10.0,
                    children: (_questions[_currentQuestionIndex]['options'] as List<String>).map((option) {
                      return Draggable<String>(
                        data: option,
                        child: AnswerBox(text: option),
                        feedback: Material(
                          color: Colors.transparent,
                          child: AnswerBox(text: option, color: Colors.grey),
                        ),
                        childWhenDragging: AnswerBox(text: option, color: Colors.grey.shade300),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 40),

                  // Drop Target Area
                  DragTarget<String>(
                    onAccept: (receivedAnswer) {
                      setState(() {
                        _droppedAnswer = receivedAnswer;
                      });
                      _checkAnswer();
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        height: 50,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _droppedAnswer ?? "Drop Answer Here",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Display feedback and score
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                _feedback,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
            Text(
              "Score: $_score",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget to represent answer options
class AnswerBox extends StatelessWidget {
  final String text;
  final Color color;

  AnswerBox({required this.text, this.color = const Color.fromARGB(255, 104, 181, 198)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
