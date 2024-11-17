import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

// Import statements remain unchanged

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confounding Color Experiment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EquipmentDragDropPage(email: "testuser@example.com"), // Pass the email here
    );
  }
}

class EquipmentDragDropPage extends StatefulWidget {
  final String email; // Add email as a parameter

  EquipmentDragDropPage({required this.email});

  @override
  _EquipmentDragDropPageState createState() => _EquipmentDragDropPageState();
}

class _EquipmentDragDropPageState extends State<EquipmentDragDropPage> {
  FlutterTts flutterTts = FlutterTts(); // Text-to-speech instance
  bool isSpeaking = false; // Flag to check if speech is playing
  List<String> draggedItems = []; // Initialize the draggedItems list
  Color currentColor = Colors.white;
  String lottieAnimationPath = 'assets/animations/7.json';

  // Instance of Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkTTSAvailability(); // Check if TTS language is available
  }

  void checkTTSAvailability() async {
    bool isAvailable = await flutterTts.isLanguageAvailable("en-US");
    if (isAvailable) {
      print("TTS is available");
    } else {
      print("TTS is not available");
    }
  }

  void speakInstruction(String item) async {
    if (isSpeaking) return;

    setState(() {
      isSpeaking = true;
    });

    switch (item) {
      case "Universal Indicator":
        await flutterTts.speak("Step 1: Add Universal Indicator, it helps in detecting pH changes.");
        break;
      case "Vinegar":
        await flutterTts.speak("Step 2: Add Vinegar, an acidic solution, to observe pH change.");
        break;
      case "Ammonia":
        await flutterTts.speak("Step 3: Add Ammonia, a basic solution, to observe pH change.");
        break;
      case "More Vinegar":
        await flutterTts.speak("Step 4: Add more Vinegar for a stronger acid.");
        break;
      default:
        await flutterTts.speak("Unknown item.");
    }

    setState(() {
      isSpeaking = false;
    });
  }

  void speakAllInstructions() {
    if (isSpeaking) return;

    setState(() {
      isSpeaking = true;
    });

    flutterTts.speak("Follow the steps to observe color changes based on pH level.");
    flutterTts.speak("Step one: Add Universal Indicator, it helps in detecting pH changes.");
    flutterTts.speak("Step two: Add Vinegar, an acidic solution, to observe pH change.");
    flutterTts.speak("Step three: Add Ammonia, a basic solution, to observe pH change.");
    flutterTts.speak("Step four: Add more Vinegar for a stronger acid. After that observe the color according to pH change.");

    setState(() {
      isSpeaking = false;
    });
  }

  void stopSpeaking() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  Future<void> saveExperimentData() async {
    try {
      // Use the email ID as a document reference
      DocumentReference docRef = _firestore
          .collection('experiments')
          .doc(widget.email)
          .collection('records')
          .doc();

      await docRef.set({
        'email': widget.email,
        'items': draggedItems,
        'timestamp': FieldValue.serverTimestamp(),
        'color': currentColor.toString(),
      });

      print('Experiment data saved for ${widget.email}');
    } catch (e) {
      print('Error saving experiment data: $e');
    }
  }

  void updateExperimentState(String item) {
    setState(() {
      if (item == "Universal Indicator") {
        currentColor = Colors.green;
      } else if (item == "Vinegar") {
        currentColor = Colors.red;
      } else if (item == "Ammonia") {
        currentColor = Colors.blue;
      } else if (item == "More Vinegar") {
        currentColor = Colors.redAccent;
      }

      draggedItems.add(item);
    });

    saveExperimentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confounding Color Experiment"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Follow the steps to observe color changes based on pH level.\n"
                "1. Add Universal Indicator\n"
                "2. Add Vinegar (Acid)\n"
                "3. Add Ammonia (Base)\n"
                "4. Add More Vinegar",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: speakAllInstructions,
                    child: Text("Play Instructions"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 49, 184, 53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: stopSpeaking,
                    child: Text("Stop Instructions"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildDraggableWithLabel("Universal Indicator", "Universal Indicator detects pH changes.", "assets/images/universal indicator.png"),
                          buildDraggableWithLabel("Vinegar", "Vinegar is an acidic solution used to test pH.", "assets/images/vinegar.png"),
                          buildDraggableWithLabel("Ammonia", "Ammonia is a basic solution used to test pH.", "assets/images/nh3.png"),
                          buildDraggableWithLabel("More Vinegar", "Add more Vinegar for a stronger acidic solution.", "assets/images/vinegar.png"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: DragTarget<String>(
                      onAccept: (data) {
                        updateExperimentState(data);
                        speakInstruction(data);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: currentColor.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/animations/5.json', width: 200, height: 200),
                                SizedBox(height: 10),
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    currentColor.withOpacity(0.5),
                                    BlendMode.srcATop,
                                  ),
                                  child: Lottie.asset(lottieAnimationPath, width: 250, height: 200),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDraggableWithLabel(String label, String description, String assetImage) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: Image.asset(assetImage, width: 80, height: 80),
      ),
      childWhenDragging: Container(),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Image.asset(assetImage, width: 80, height: 80),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
