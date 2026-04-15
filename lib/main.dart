import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FeedGame extends StatefulWidget {
  @override
  _FeedGameState createState() => _FeedGameState();
}

class _FeedGameState extends State<FeedGame> {
  final player = AudioPlayer();

  String message = "I'm hungry!";
  String currentImage = "neutral";

  void feedCharacter(String food) async {
    if (food == "🍎") {
      currentImage = "apple";
      message = "Apple Yummy 😄";
      await player.play(AssetSource('yummy.mp3'));
    } else if (food == "🍌") {
      currentImage = "banana";
      message = "Banana Yummy 😄";
      await player.play(AssetSource('yummy.mp3'));
    } else if (food == "🥦") {
      currentImage = "broccoli";
      message = "Broccoli Yummy 😄";
      await player.play(AssetSource('yummy.mp3'));
    } else {
      currentImage = "sad";
      message = "Not Good 👎";
      await player.play(AssetSource('no.mp3'));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // 🌈 BACKGROUND
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade100,
              Colors.blue.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              // 🎮 TITLE CARD
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Text(
                  "Ma... Oliver Hungryyy 😋",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // 🧸 CHARACTER GAME BOX
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                      ),
                    ],
                  ),

                  child: Center(
                    child: DragTarget<String>(
                      onAccept: (data) {
                        feedCharacter(data);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Image.asset(
                              currentImage == "apple"
                                  ? "assets/apple.png"
                                  : currentImage == "banana"
                                      ? "assets/banana.png"
                                      : currentImage == "broccoli"
                                          ? "assets/broccoli.png"
                                          : currentImage == "sad"
                                              ? "assets/sad.png"
                                              : "assets/neutral.png",
                              height: 400,
                            ),

                            SizedBox(height: 10),

                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              // 🍎 FOOD TRAY
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    foodItem("🍎"),
                    foodItem("🍌"),
                    foodItem("🥦"),
                    foodItem("🍰"),
                    foodItem("🍬"),
                    foodItem("🧃"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🍎 DRAGGABLE FOOD
  Widget foodItem(String food) {
    return Draggable<String>(
      data: food,
      feedback: Material(
        color: Colors.transparent,
        child: Text(food, style: TextStyle(fontSize: 40)),
      ),
      child: Text(food, style: TextStyle(fontSize: 40)),
    );
  }
}