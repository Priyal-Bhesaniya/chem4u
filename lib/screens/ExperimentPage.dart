import 'package:chemlab_flutter_project/screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExperimentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Experiment"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            
            icon: const Icon(Icons.person_outline,size: 30,),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute( builder: (context) => ProfilePage(),)
                // Replace with your profile page widget
              );
              // Handle profile navigation or action here
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
                image: AssetImage("assets/images/experiments.png"), // Add your background image
                
              ),
            ),
              ),

          SizedBox(height: 30),

          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color.fromARGB(255, 104, 181, 198),
            ),
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Experiment 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),


            SizedBox(height: 5),

          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color.fromARGB(255, 104, 181, 198),
            ),
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Experiment 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

            SizedBox(height: 5),

          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color.fromARGB(255, 104, 181, 198),
            ),
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Experiment 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

            SizedBox(height: 5),

          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color.fromARGB(255, 104, 181, 198),
            ),
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Experiment 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

            SizedBox(height: 5),

          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Color.fromARGB(255, 104, 181, 198),
            ),
            margin: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Experiment 1",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ));

    
  }
}
