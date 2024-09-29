import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 205, 220),  // Background color matching the image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  Color.fromARGB(255, 104, 181, 198),
                
              ),
              child: Text(
                'Hi ! Priyal',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            //Icon(Icons.person_outline, color: Colors.black, size: 30),
            IconButton(onPressed: (){
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>  ProfileScreen(), // Replace with your next page widget
              //     ),
              //   );

            }, icon: Icon(Icons.person_outline, color: Colors.black, size:30))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image of the character/lady
          Container(
            height: 200,
            child: Lottie.asset('assets/animations/Mainpage1.json'), // Ensure you have this image in the assets
          ),
          SizedBox(height: 30),
          
          // Row with buttons for Quiz, Modulas, Experiments, and Notes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Quiz button
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle quiz button press
                    },
                    child: Image.asset(
                      'assets/images/quiz.png', // Quiz image
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Quiz', style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),

              // Modulas button
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle modulas button press
                    },
                    child: Image.asset(
                      'assets/images/modulas.png', // Modulas image
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Modulas', style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Experiments button
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle experiments button press
                    },
                    child: Image.asset(
                      'assets/images/experiments.png', // Experiments image
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Experiments', style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),

              // Notes button
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle notes button press

                      
                    },
                    child: Image.asset(
                      'assets/images/notes.png', // Notes image
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Notes', style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
