import 'package:flutter/material.dart';
import 'package:garbagecollector/carbage.dart';

class homePage extends StatefulWidget {
  const homePage({ Key? key }) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(flex: 2, 
          child: AnimatedContainer(
            alignment: Alignment(0,1),
            duration: Duration(milliseconds: 0),
            color:Colors.blue,
            child: garbageMaterial(),
            )),
          Expanded(child: Container(color : Colors.green)),
        ],
      )
    );
  }
}
