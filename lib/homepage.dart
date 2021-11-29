import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garbagecollector/carbage.dart';

final List<String> garbageBins = ['Green', 'Blue', 'Yellow', 'Red'];

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static double carbageYaxis = -1.2;
  int currentPos = 0;
  double time = 0;
  double height = 0;
  double initialHeight = carbageYaxis;
  int score = 0;
  bool gameStarted = false;

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.007;
      height = -4.9 * time * time;
      setState(() {
        carbageYaxis = initialHeight - height;
      });
      if (carbageYaxis > 1.7) {
        timer.cancel();
        gameStarted = false;
      }
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
                    color: Colors.lightGreen,
                    child: garbageMaterial(),
                  ),
                ),
                Container(
                    alignment: Alignment(0, 0),
                    child: gameStarted
                        ? Text('')
                        : Text('Tap to start' + currentPos.toString()))
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
                    currentPos = index;
                  });
                }),
            itemBuilder: (ctx, index, realIdx) {
              return MyImageView(garbageBins[index]);
            },
            //  {
            //   return Builder(
            //     builder: (BuildContext context) {
            //       return Container(
            //           width: MediaQuery.of(context).size.width,
            //           decoration: BoxDecoration(color: Colors.amber),
            //           child: Text(,
            //             style: TextStyle(fontSize: 16.0),
            //           ));
            //     },
            //   );
            // }).toList(),
          )),
        ],
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(imgPath));
    // margin: EdgeInsets.symmetric(horizontal: 5),
    // child: FittedBox(
    //   fit: BoxFit.fill,
    //   child: Image.asset(imgPath),
    // ));
  }
}
