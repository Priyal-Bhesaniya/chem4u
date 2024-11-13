import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:chemlab_flutter_project/screens/ProfilePage.dart';

class CleanNotesPage extends StatefulWidget {
  @override
  _CleanNotesPageState createState() => _CleanNotesPageState();
}

class _CleanNotesPageState extends State<CleanNotesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];

  // Reference to Firestore collection (change 'notes' to your desired collection name)
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load notes when the page is first created
  }

  // Fetch notes from Firestore
  Future<void> _loadNotes() async {
    try {
      QuerySnapshot snapshot = await notesCollection.orderBy('timestamp').get();
      List<String> fetchedNotes = snapshot.docs.map((doc) {
        return doc['note'] as String;
      }).toList();
      setState(() {
        _notes.clear();  // Clear the current list of notes
        _notes.addAll(fetchedNotes);  // Add fetched notes to the list
      });
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  // Add a new note to Firestore
  Future<void> _addNote() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _notes.add(_controller.text);
      });
      await notesCollection.add({
        'note': _controller.text,
        'timestamp': FieldValue.serverTimestamp(), // optional: for ordering
      });
      _controller.clear(); // Clear the input field after adding a note
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
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
                image: AssetImage("assets/images/notes.png"), // Add your background image
              ),
            ),
          ),
          SizedBox(height: 20),

          // Input field for new notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Write your note...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Display notes
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
