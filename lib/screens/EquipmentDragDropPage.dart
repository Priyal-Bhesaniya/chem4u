import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: EquipmentDragDropPage(),
    );
  }
}

class EquipmentDragDropPage extends StatefulWidget {
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

  // Function to check TTS language availability
  void checkTTSAvailability() async {
    bool isAvailable = await flutterTts.isLanguageAvailable("en-US");
    if (isAvailable) {
      print("TTS is available");
    } else {
      print("TTS is not available");
    }
  }

  // Function to speak instructions for each item
  void speakInstruction(String item) async {
    if (isSpeaking) return; // Prevent speaking while speech is ongoing

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

  // Function to speak all instructions when play button is pressed
  void speakAllInstructions() {
    if (isSpeaking) return; // Prevent multiple calls while speaking

    setState(() {
      isSpeaking = true;
    });

    // Speak all instructions simultaneously
    flutterTts.speak("Follow the steps to observe color changes based on pH level.");
    flutterTts.speak("Step one: Add Universal Indicator, it helps in detecting pH changes.");
    flutterTts.speak("Step two: Add Vinegar, an acidic solution, to observe pH change.");
    flutterTts.speak("Step three: Add Ammonia, a basic solution, to observe pH change.");
    flutterTts.speak("Step four: Add more Vinegar for a stronger acid.");

    setState(() {
      isSpeaking = false;
    });
  }

  // Function to stop all speech when stop button is pressed
  void stopSpeaking() async {
    await flutterTts.stop(); // Stop any ongoing speech
    setState(() {
      isSpeaking = false;
    });
  }

  // Function to save the experiment data to Firebase
  Future<void> saveExperimentData() async {
    try {
      // Creating a reference to the Firestore collection
      DocumentReference docRef = await _firestore.collection('experiments').add({
        'items': draggedItems,
        'timestamp': FieldValue.serverTimestamp(),
        'color': currentColor.toString(),
      });

      // You can also add additional data such as the timestamp of when the experiment was done
      print('Experiment data saved with ID: ${docRef.id}');
    } catch (e) {
      print('Error saving experiment data: $e');
    }
  }

  // Update experiment state and save to Firestore
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

      draggedItems.add(item); // Add the item to the draggedItems list
    });

    // Save the experiment data to Firestore after an item is dropped
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
      body: SafeArea( // Wrap the body with SafeArea to avoid overflow
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
            // Row for Play and Stop Buttons side by side
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Align buttons in center
                children: [
                  ElevatedButton(
                    onPressed: speakAllInstructions, // Trigger voice instructions
                    child: Text("Play Instructions"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 49, 184, 53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                  SizedBox(width: 20), // Add some space between the buttons
                  ElevatedButton(
                    onPressed: stopSpeaking, // Trigger stop speech
                    child: Text("Stop Instructions"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red,
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
                  // Left Column - Equipment to Drag with Labels and Descriptions
                  Expanded(
                    child: SingleChildScrollView( // Make this scrollable to prevent overflow
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
                  // Right Column - Drop Target with Lottie Animation and Color Filter
                  Expanded(
                    child: DragTarget<String>( 
                      onAccept: (data) {
                        updateExperimentState(data); // This will now store the data in Firestore
                        speakInstruction(data); // Speak the instruction for the item
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: currentColor.withOpacity(0.2),
                          ),
                          width: double.infinity,
                          height: double.infinity,
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

  // Widget to create Draggable with Label and Description
  Widget buildDraggableWithLabel(String label, String description, String assetImage) {
    return Draggable<String>(
      data: label, // Data to be passed when dragged
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
