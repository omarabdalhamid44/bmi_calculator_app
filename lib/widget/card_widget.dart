import 'package:bmi_calculater/contans/color_file.dart';
import 'package:flutter/material.dart';

class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key? key, required this.child,this.height=150}) : super(key: key);
  Widget child;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
        color: backGroundCardColor,
        child: child);
  }
}
