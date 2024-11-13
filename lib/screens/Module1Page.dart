import 'package:flutter/material.dart';

class Module1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Module 1"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Definition of Module 1:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Experiment: pH Level Changes Using Indicators, Acids, and Bases",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Materials:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "• Universal Indicator: Changes color to indicate the pH (red for acidic, green for neutral, blue for basic).",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "• Vinegar: An acidic solution that lowers the pH.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "• Ammonia: A basic solution that raises the pH.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Procedure:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "1. Add Universal Indicator: Start with a neutral color (green).",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "2. Add Vinegar: Turns the solution red, showing it’s acidic.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "3. Add Ammonia: Turns the solution blue, indicating it’s basic.",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "4. Add More Vinegar: Deepens the red color, making the solution more acidic.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Purpose:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              "This experiment helps visualize how acids and bases affect pH, using the color changes of the indicator as a simple demonstration of acidity and alkalinity.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
