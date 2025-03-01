import 'package:flutter/material.dart';

class ForumFunctionality extends StatefulWidget {
  @override
  _ForumFunctionalityState createState() => _ForumFunctionalityState();
}

class _ForumFunctionalityState extends State<ForumFunctionality> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  void submitPost() {
    if (titleController.text.isNotEmpty && subjectController.text.isNotEmpty) {
      // Returns the data to be used in the social page as a map <String, String>
      Navigator.pop(context, {
        "title": titleController.text,
        "subject": subjectController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade300,
              const Color.fromARGB(255, 79, 218, 102),
            ],
            stops: [0.1, 0.5, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Post Title",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: "Post Content",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
