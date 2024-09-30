import 'package:flutter/material.dart';

class ExperimentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Experiment"),
        backgroundColor: const Color.fromARGB(255, 116, 169, 193),
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
              // Handle profile navigation or action here
            },
          ),
        ],
      ),

      body: Container(
         color: Color.fromARGB(255, 104, 181, 198),
         margin: EdgeInsets.all(16.0), 
        height: 90,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/experiments.png"), // Add your background image
            
          ),
        ),
    ));
  }
}
