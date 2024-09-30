//home page//

// import 'package:flutter/material.dart';
// import 'package:main_flutter_project/screens/HomePage.dart';
//  // Import your HomePage widget

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chem4u App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(), // Set the HomePage as the initial screen
//     );
//   }
// }


// loading page //


// import 'package:flutter/material.dart';
// import 'package:main_flutter_project/screens/LoadingPage.dart';
//  // Import your LoadingPage widget

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Loading Screen App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoadingPage(), // Set the LoadingPage as the home screen
//     );
//   }
// }




// Androiodlarge3 //

// import 'package:flutter/material.dart';
// import 'package:main_flutter_project/screens/AndroidLarge3.dart';
// // Import your AndroidLarge3 widget
 
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Custom UI App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: LoginPage(), // Set the AndroidLarge3 as the initial screen
//       ),
//     );
//   }
// }





import 'package:chemlab_flutter_project/screens/ExperimentPage.dart';
import 'package:chemlab_flutter_project/screens/LoadingPage.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ExperimentPage(),
    );
  }
}