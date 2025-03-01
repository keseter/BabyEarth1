import 'package:baby_earth/pages/social_page.dart';
import 'package:baby_earth/pages/task_page.dart';
import 'package:flutter/material.dart';
import 'news_api.dart'; // Import your news API file

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Colorful background color
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900, // Dark blue at the top
              Colors.blue.shade300, // Lighter blue in the middle
              const Color.fromARGB(255, 79, 218, 102), // Green at the bottom
            ],
            stops: [0.1, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            // App Bar
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
                  const Spacer(),
                  Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 7, 68, 237),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          "Login: ",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  blurRadius: 10.0, color: Colors.cyanAccent),
                              Shadow(blurRadius: 20.0, color: Colors.cyan),
                              Shadow(
                                  blurRadius: 30.0,
                                  color: Colors.lightBlueAccent),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "0", // Later for setState
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  blurRadius: 10.0, color: Colors.cyanAccent),
                              Shadow(blurRadius: 20.0, color: Colors.cyan),
                              Shadow(
                                  blurRadius: 30.0,
                                  color: Colors.lightBlueAccent),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // **News Section**
            Container(
              width: 380,
              height: 370,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 16, 128, 203), // Blue
                    const Color.fromARGB(255, 50, 61, 222), // Dark Blue
                  ],
                  stops: [0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                // Fit based on the container size
                borderRadius: BorderRadius.circular(30),
                child:
                    NewsAPI(), // Display the news feed page inside this container
              ),
            ),
            SizedBox(
              height: 1,
            ),

            // Tree counter widget
            Container(
                height: 60,
                width: 390,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/forest.png"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(children: [
                  SizedBox(width: 20),
                  Text(
                    "Tree Counter:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(width: 20),
                  Text("0",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30))
                ])),
            const SizedBox(height: 70),

            // Buttons
            Row(
              children: [
                SizedBox(width: 70),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SocialPage()));
                  },
                  child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/social.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage()));
                  },
                  child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/plant.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(width: 50),
                Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/other.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10))),
              ],
            ),
            SizedBox(
              height: 5,
            ),

            // Row for the buttons name
            Row(children: [
              SizedBox(width: 77),
              Text("Social"),
              SizedBox(width: 71),
              Text("Task"),
              SizedBox(width: 72),
              Text("Other"),
            ])
          ],
        ),
      ),
    );
  }
}
