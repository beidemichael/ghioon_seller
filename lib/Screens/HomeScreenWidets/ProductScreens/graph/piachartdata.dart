import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Statistics {
  static List<Data> data = [
    Data(name: 'Blue', percentage: 15.0, color: Color(0xff0293ee)),
    Data(name: 'Brown', percentage: 20.0, color: Colors.green),
    Data(name: 'Black', percentage: 35.0, color: Colors.black),
    Data(name: 'Blue', percentage: 30.0, color: Colors.red),
  ];
}

class Data {
  final String name;
  final double percentage;
  final Color color;
  Data({required this.name, required this.percentage, required this.color});
}
