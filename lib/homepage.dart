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

const greeting = 'Hi Fiona';
const startText = 'T A P    T O   S T A R T';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static double carbageYaxis = -1.5;
  int selectedGarbageDisposal = 0;
  double time = 0;
  double height = 0;
  double initialHeight = carbageYaxis;
  int score = 0;
  bool gameStarted = false;
  var rng = new Random();
  int randomGarbageType = 0;
  int randomImage = 0;

  void startGame() {
    randomGarbageType = rng.nextInt(4);
    randomImage = rng.nextInt(2);
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.007 + (0.007 * (log(pow(1.2, score))));
      height = -4.9 * time * time;
      setState(() {
        carbageYaxis = initialHeight - height;
      });
      setState(() {
        if (carbageYaxis > 1.25) {
          if (score == 5) {
            timer.cancel();
          }
          if (randomGarbageType == selectedGarbageDisposal) {
            // Correct bin, so add score and restart
            carbageYaxis = -1.5;
            time = 0;
            score++;
            randomGarbageType = rng.nextInt(4);
          } else {
            // Wrong bin, stop game
            timer.cancel();
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
                    child: garbageMaterial(randomGarbageType, randomImage),
                  ),
                ),
                Container(
                    alignment: Alignment(0, 0),
                    child: gameStarted
                        ? Text(score.toString() + ' / 5',
                            style: TextStyle(color: Colors.grey, fontSize: 20))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                greeting,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 35),
                              ),
                              Text(
                                startText,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            ],
                          ))
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
