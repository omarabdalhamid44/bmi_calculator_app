import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {

String text;
double fontSize;
FontWeight fontWeight;
Color? color;
TextWidget({required this.text, this.fontSize=15, this.fontWeight=FontWeight.w600,this.color});

  @override
  Widget build(BuildContext context) {
    return Text (text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
    ),);
  }
}