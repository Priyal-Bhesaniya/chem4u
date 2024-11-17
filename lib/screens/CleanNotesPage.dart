import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CleanNotesPage extends StatefulWidget {
  @override
  _CleanNotesPageState createState() => _CleanNotesPageState();
}

class _CleanNotesPageState extends State<CleanNotesPage> {
  final TextEditingController _controller = TextEditingController();
  String? userEmail;

  // Firestore collection reference
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserEmail();
  }

  // Fetch the current user's email
  Future<void> _fetchCurrentUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email; // Get the email of the logged-in user
        });
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print("Error fetching user email: $e");
    }
  }

  // Add a new note to Firestore
  Future<void> _addNote() async {
    if (_controller.text.isNotEmpty && userEmail != null) {
      try {
        String noteContent = _controller.text;

        // Save the note to Firestore
        await notesCollection.add({
          'note': noteContent,
          'email': userEmail, // Associate the note with the user's email
          'timestamp': FieldValue.serverTimestamp(), // Store timestamp
        });

        _controller.clear(); // Clear the input field
        print("Note added successfully!");
      } catch (e) {
        print("Error adding note: $e");
      }
    } else {
      print("Note content is empty or userEmail is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        backgroundColor: const Color.fromARGB(255, 104, 181, 198),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Input field for new notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Write your note...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addNote,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Optional: Display message if no note has been added
          const Expanded(
            child: Center(
              child: Text(
                "Add your notes here.",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
