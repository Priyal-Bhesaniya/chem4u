import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

  void _checkAnswer(int index, String droppedItem) {
    setState(() {
      if (droppedItem == correctAnswers[index]) {
        score++;
        feedback = 'Correct!';
      } else {
        feedback = 'Incorrect. Try again!';
      }
      if (answers.every((answer) => answer.isNotEmpty)) {
        quizCompleted = true;
      }
    });
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
        
              // Completion message and Lottie animation
              if (quizCompleted)
                Column(
                  children: [
                    Text(
                      'Quiz Complete! Final Score: $score/${targetNames.length}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    if (score > 3)
                      Lottie.asset(
              'assets/animations/pop2.json', // Path to your Lottie animation file
                        width: 150,
                        height: 150,
                        repeat: false,
                      ),
                  ],
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
