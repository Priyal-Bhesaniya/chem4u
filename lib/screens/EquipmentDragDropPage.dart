import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MaterialApp(home: EquipmentDragDropPage()));

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
        await flutterTts.speak("Step 1: Add Universal Indicator.");
        break;
      case "Vinegar":
        await flutterTts.speak("Step 2: Add Vinegar, an acidic solution.");
        break;
      case "Ammonia":
        await flutterTts.speak("Step 3: Add Ammonia, a basic solution.");
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
    flutterTts.speak("Step one: Add Universal Indicator.");
    flutterTts.speak("Step two: Add Vinegar, an acidic solution.");
    flutterTts.speak("Step three: Add Ammonia, a basic solution.");
    flutterTts.speak("Step one: Add Universal Indicator, Step two: Add Vinegar, an acidic solution, Step three: Add Ammonia, a basic solution, Step four: Add more Vinegar for a stronger acid.");

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
    });
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
                  // Left Column - Equipment to Drag with Labels
                  Expanded(
                    child: SingleChildScrollView( // Make this scrollable to prevent overflow
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildDraggableWithLabel("Universal Indicator", "assets/images/universal indicator.png"),
                          buildDraggableWithLabel("Vinegar", "assets/images/vinegar.png"),
                          buildDraggableWithLabel("Ammonia", "assets/images/nh3.png"),
                          buildDraggableWithLabel("More Vinegar", "assets/images/vinegar.png"),
                        ],
                      ),
                    ),
                  ),
                  // Right Column - Drop Target with Lottie Animation and Color Filter
                  Expanded(
                    child: DragTarget<String>( 
                      onAccept: (data) {
                        updateExperimentState(data);
                        setState(() {
                          draggedItems.add(data); // Add dragged item to the list
                        });
                        speakInstruction(data); // Call speakInstruction when an item is dropped
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
                                // Dropper Animation
                                Lottie.asset(
                                  'assets/animations/5.json',
                                  width: 200,
                                  height: 200,
                                ),
                                SizedBox(height: 10),
                                // Flask Animation with Color Filter
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    currentColor.withOpacity(0.5),
                                    BlendMode.srcATop,
                                  ),
                                  child: Lottie.asset(
                                    lottieAnimationPath,
                                    width: 250,
                                    height: 200,
                                  ),
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

  // Function to build draggable items with a label
  Widget buildDraggableWithLabel(String name, String imagePath) {
    return Column(
      children: [
        Draggable<String>( 
          data: name,
          feedback: Material(
            child: EquipmentBox(name: name, imagePath: imagePath, isFeedback: true),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: EquipmentBox(name: name, imagePath: imagePath),
          ),
          child: EquipmentBox(name: name, imagePath: imagePath),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// Widget for displaying draggable equipment
class EquipmentBox extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isFeedback;

  EquipmentBox({required this.name, required this.imagePath, this.isFeedback = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isFeedback ? Colors.blueAccent : Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
