import 'package:flutter/material.dart';

List garbageBins = [
  Colors.green,
  Colors.yellow,
  Colors.blue,
  Colors.red,
];

class garbageMaterial extends StatelessWidget {
  garbageMaterial(this.garbageType);
  final int garbageType;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      color: garbageBins[garbageType],
    );
  }
}
