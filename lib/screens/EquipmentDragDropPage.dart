import 'package:flutter/material.dart';

class EquipmentDragDropPage extends StatefulWidget {
  @override
  _EquipmentDragDropPageState createState() => _EquipmentDragDropPageState();
}

class _EquipmentDragDropPageState extends State<EquipmentDragDropPage> {
  List<String> draggedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Experiment 1"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, size: 30),
            onPressed: () {
              // Navigate to Profile Page
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Titration: a technique used to measure the volume of a solution of known concentration that is required to react with a measured amount (mass or volume) of an unknown substance in solution.\n\n"
              "Buret: an instrument used to measure volume; a graduated glass tube about 40 cm long with a stopcock on one end.",
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
                      buildDraggableItem("Buret", "assets/images/buret.png"),
                      buildDraggableItem("Flask", "assets/images/flask.png"),
                      buildDraggableItem("Beaker", "assets/images/beaker.png"),
                    ],
                  ),
                ),

                // Right Column - Drop Target
                Expanded(
                  child: DragTarget<String>(
                    onAccept: (data) {
                      setState(() {
                        draggedItems.add(data);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.lightBlue[50],
                        ),
                        child: Stack(
                          children: [
                            for (String item in draggedItems)
                              Positioned(
                                top: draggedItems.indexOf(item) * 100.0,
                                child: DraggableItemBox(item),
                              ),
                            Center(
                              child: Text(
                                draggedItems.isEmpty
                                    ? "Drop Equipment Here"
                                    : "",
                                style: TextStyle(fontSize: 20, color: Colors.black38),
                              ),
                            ),
                          ],
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

// Widget for positioning dropped items inside the drop target area
class DraggableItemBox extends StatelessWidget {
  final String name;

  DraggableItemBox(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
