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
              "Try the Briggs-Rauscher Oscillating Clock Reaction  The Oscillating Clock or Briggs-Rauscher reaction changes color from clear to amber to blue. The reaction cycles between colors for a few minutes, eventually turning blue-black.",
            
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("Solution A Add 43 g potassium iodate (KIO3) to ~800 mL distilled water. Stir in 4.5 mL sulfuric acid (H2SO4). Continue stirring until the potassium iodate is dissolved. Dilute to 1 L."),
            // You can add more content here
          ],
        ),
      ),
    );
  }
}
