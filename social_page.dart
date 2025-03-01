import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:baby_earth/pages/forum_card.dart";
import "package:baby_earth/pages/forum_functionality.dart";

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  late Box _forumBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _forumBox = await Hive.openBox('forumPosts');
    setState(() {}); // Refresh UI after box is ready
  }

  void addPost(String title, String subject) {
    final post = {"title": title, "subject": subject};
    _forumBox.add(post); // Save post to Hive
    setState(() {}); // Refresh UI
  }

  void deletePost(int index) {
    _forumBox.deleteAt(index); // Delete post from Hive
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen('forumPosts')) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
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
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Image.asset(
                      "assets/babyEarth.png",
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "BabyEarth",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _forumBox.listenable(),
                builder: (context, Box box, _) {
                  if (box.isEmpty) {
                    return Center(
                      child: Text("No posts yet.",
                          style: TextStyle(color: Colors.white)),
                    );
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final post = box.getAt(index);
                      return ForumCard(
                        title: post["title"],
                        subject: post["subject"],
                        onDelete: () =>
                            deletePost(index), // Pass delete function
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForumFunctionality()),
          );

          if (result != null && result is Map<String, String>) {
            addPost(result["title"]!, result["subject"]!);
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
