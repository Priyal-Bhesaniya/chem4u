import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(MaterialApp(home: EquipmentDragDropPage()));

class EquipmentDragDropPage extends StatefulWidget {
  @override
  _EquipmentDragDropPageState createState() => _EquipmentDragDropPageState();
}

class _EquipmentDragDropPageState extends State<EquipmentDragDropPage> {
  List<String> draggedItems = [];
  
  Color currentColor = Colors.transparent;
  String lottieAnimationPath = 'assets/animations/7.json'; // Initial animation

  void updateExperimentState(String item) {
    setState(() {
      if (item == "Universal Indicator") {
        currentColor = Colors.green; // Color for Indicator
      } else if (item == "Vinegar") {
        currentColor = Colors.red; // Color for Acidic solution
      } else if (item == "Ammonia") {
        currentColor = Colors.blue; // Color for Basic solution
      } else if (item == "More Vinegar") {
        currentColor = Colors.redAccent; // Color for Strong Acid
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
      body: Column(
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
          Expanded(
            child: Row(
              children: [
                // Left Column - Equipment to Drag
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildDraggableItem("Universal Indicator", "assets/images/indicator.png"),
                      buildDraggableItem("Vinegar", "assets/images/vinegar.png"),
                      buildDraggableItem("Ammonia", "assets/images/ammonia.png"),
                      buildDraggableItem("More Vinegar", "assets/images/vinegar.png"),
                    ],
                  ),
                ),
                // Right Column - Drop Target with Lottie Animation and Color Filter
                Expanded(
                  child: DragTarget<String>(
                    onAccept: (data) {
                      updateExperimentState(data);
                      setState(() {
                        draggedItems.add(data);
                      });
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
                                height: 200
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
                                  height: 250,
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
    );
  }

  // Function to build draggable equipment items
  Widget buildDraggableItem(String name, String imagePath) {
    return Draggable<String>(
      data: name,
      feedback: Material(
        child: EquipmentBox(name: name, imagePath: imagePath, isFeedback: true),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: EquipmentBox(name: name, imagePath: imagePath),
      ),
      child: EquipmentBox(name: name, imagePath: imagePath),
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
