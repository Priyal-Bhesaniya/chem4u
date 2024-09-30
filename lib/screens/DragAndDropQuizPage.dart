import 'package:flutter/material.dart';

class DragAndDropQuizPage extends StatefulWidget {
  @override
  _DragAndDropQuizPageState createState() => _DragAndDropQuizPageState();
}

class _DragAndDropQuizPageState extends State<DragAndDropQuizPage> {
  List<String> draggableItems = ['A', 'B', 'C', 'D'];
  List<String> targets = ['', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz 1: Drag and Drop'),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Left side: Draggable items
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(draggableItems.length, (index) {
                return Draggable<String>(
                  data: draggableItems[index],
                  child: DraggableItemBox(draggableItems[index]),
                  feedback: Material(
                    child: DraggableItemBox(draggableItems[index], isFeedback: true),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: DraggableItemBox(draggableItems[index]),
                  ),
                );
              }),
            ),

            // Right side: Drop targets
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(targets.length, (index) {
                return DragTarget<String>(
                  onAccept: (receivedItem) {
                    setState(() {
                      targets[index] = receivedItem;
                    });
                  },
                  builder: (context, acceptedItems, rejectedItems) {
                    return TargetItemBox(targets[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for draggable items
class DraggableItemBox extends StatelessWidget {
  final String item;
  final bool isFeedback;

  DraggableItemBox(this.item, {this.isFeedback = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isFeedback ? Colors.blueAccent : Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          item,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Widget for drop target items
class TargetItemBox extends StatelessWidget {
  final String item;

  TargetItemBox(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: item.isEmpty ? Colors.grey[300] : Colors.greenAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          item.isEmpty ? 'Drop Here' : item,
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
