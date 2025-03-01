import "package:flutter/material.dart";
import "dart:async";
import 'home_page.dart'; // Import the HomePage

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentImageIndex = 0;
  final List<String> _imagePaths = [
    "assets/babyEarth.png",
    "assets/yayEarth.png"
  ];

  @override
  void initState() {
    super.initState();
    // Start animation loop
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        // Image tracking modulo to reset it to the original image
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rainbow image in the background
          Align(
            alignment: Alignment.topRight, // Align to the top right
            child: Image.asset(
              "assets/rainbow.png",
              width: 430,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
          // Main content area
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            children: [
              // Animated image section
              Center(
                child: SizedBox(
                  width: 300, // Set desired width
                  height: 300, // Set desired height
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1), // Smooth transition time
                    child: Image.asset(
                      _imagePaths[_currentImageIndex],
                      key: ValueKey<String>(_imagePaths[_currentImageIndex]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between image and text
              // Container for the text with navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16), // Padding inside the container
                  margin:
                      EdgeInsets.only(bottom: 130), // Margin from the bottom
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 12, 124, 215), // Background color with opacity
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, // Shadow color
                        offset: Offset(0, 4), // Shadow position
                        blurRadius: 8, // Shadow blur radius
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to Baby Earth!",
                        style: TextStyle(
                          fontSize: 24, // Increase font size
                          fontWeight: FontWeight.bold, // Make it bold
                          color: Colors.white, // Text color
                        ),
                        textAlign: TextAlign.center, // Center the text
                      ),
                      SizedBox(height: 8), // Space between title and subtitle
                      Text(
                        "What on Earth is going on?!",
                        style: TextStyle(
                          fontSize: 16, // Subtitle font size
                          color: Colors.white, // Text color
                        ),
                        textAlign: TextAlign.center, // Center the text
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
