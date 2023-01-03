import 'dart:math';

import 'package:flutter/material.dart';
class CalculatorModel{
  final double height;
  final double weight;

  CalculatorModel(this.height,this.weight);

   double result=0;
  double calculator() {
    result= weight / pow((height.toDouble()/100), 2);
    print(result);
    return result;
  }


  String? type;
  String? status;
  Color? color;

  Map<String, String> map = {
    'Underweight': '≤ 18 Kg',
    'Normal': '18.5 Kg - 25 Kg',
    'Overweight': '25 Kg - 39.9 Kg',
    'Obese': ' ≥ 40.0'
  };
  void changeValues() {
    if (result <= 18.5&& result >=0) {
      status = map['Underweight'];
      type = map.keys.elementAt(0);
      color = Colors.yellow;
    } else if (result > 18.5 && result <= 25) {
      status = map['Normal']!;
      type = map.keys.elementAt(1);
      color = Colors.lightGreenAccent;
    } else if (result >= 25 && result <= 39.9) {
      status = map['Overweight']!;
      type = map.keys.elementAt(2);
      color = Colors.orange;
    } else  if(result >= 40){
      status = map['Obese']!;
      type = map.keys.elementAt(3);
      color = Colors.red;
    }
  }}