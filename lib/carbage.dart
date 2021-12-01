import 'package:flutter/material.dart';
import 'dart:math';

List garbageBins = [
  Colors.green,
  Colors.yellow,
  Colors.blue,
  Colors.red,
];

List garbageItems = [
  ['assets/images/apple.png', 'assets/images/fish.png'],
  ['assets/images/bible.png', 'assets/images/paperPlane.png'],
  ['assets/images/cpu.png', 'assets/images/phone.png'],
  ['assets/images/bandage.png', 'assets/images/siringe.png']
];

var rng = new Random();

class garbageMaterial extends StatelessWidget {
  garbageMaterial(this.garbageType, this.imageIndex);
  final int garbageType;
  final int imageIndex;
  @override
  int randomGarbageType = 0;
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset(garbageItems[garbageType][imageIndex]),
    );
  }
}
