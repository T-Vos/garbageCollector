import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garbagecollector/carbage.dart';

List<String> garbageBins = [
  'assets/images/GreenBin.png',
  'assets/images/YellowBin.png',
  'assets/images/BlueBin.png',
  'assets/images/RedBin.png',
];

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static double carbageYaxis = -1.2;
  int selectedGarbageDisposal = 0;
  double time = 0;
  double height = 0;
  double initialHeight = carbageYaxis;
  int score = 0;
  bool gameStarted = false;
  var rng = new Random();
  int randomGarbageType = 0;

  void startGame() {
    randomGarbageType = rng.nextInt(4);
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.007;
      height = -4.9 * time * time;
      setState(() {
        carbageYaxis = initialHeight - height;
      });
      setState(() {
        if (carbageYaxis > 1.25) {
          if (randomGarbageType == selectedGarbageDisposal) {
            // Correct bin, so add score and restart
            carbageYaxis = -1.2;
            time = 0;
            score++;
            randomGarbageType = rng.nextInt(4);
          } else {
            // Wrong bin, stop game
            timer.cancel();
            gameStarted = false;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!gameStarted) {
                      startGame();
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment(0, carbageYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.white,
                    child: garbageMaterial(randomGarbageType),
                  ),
                ),
                Container(
                    alignment: Alignment(0, 0),
                    child: gameStarted
                        ? Text(score.toString() + '/3')
                        : Text('Tap to start'))
              ],
            ),
          ),
          Expanded(
              child: CarouselSlider.builder(
            itemCount: garbageBins.length,
            options: CarouselOptions(
                height: 400.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    selectedGarbageDisposal = index;
                  });
                }),
            itemBuilder: (ctx, index, realIdx) {
              return MyImageView(garbageBins[index]);
            },
          )),
        ],
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  MyImageView(this.imgPath);
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        color: Colors.white,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.asset(imgPath),
        ));
  }
}
