import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chemlab_flutter_project/screens/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CleanNotesPage extends StatefulWidget {
  @override
  _CleanNotesPageState createState() => _CleanNotesPageState();
}

class _CleanNotesPageState extends State<CleanNotesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser; // Get the current logged-in user

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Fetch saved notes when the page loads
  }

  void _addNote() async {
    if (_controller.text.isNotEmpty && currentUser != null) {
      String noteContent = _controller.text;

      // Add note to Firestore
      await _firestore
          .collection('users')
          .doc(currentUser!.email)
          .collection('notes')
          .add({
        'content': noteContent,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update local state and clear the input
      setState(() {
        _notes.add(noteContent);
        _controller.clear();
      });
    }
  }

  void _fetchNotes() async {
    if (currentUser != null) {
      // Fetch notes from Firestore
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(currentUser!.email)
          .collection('notes')
          .orderBy('timestamp', descending: true)
          .get();

      List<String> fetchedNotes = snapshot.docs
          .map((doc) => doc['content'] as String)
          .toList();

      // Update the state with fetched notes
      setState(() {
        _notes.addAll(fetchedNotes);
      });
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
