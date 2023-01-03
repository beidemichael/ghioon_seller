import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/graph/piachartdata.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/graph/piechart.dart';

List<PieChartSectionData> getSections() => Statistics.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
          color: data.color,
          value: data.percentage,
          title: '${data.percentage}%',
          titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff)));
      return MapEntry(index, value);
    })
    .values
    .toList();
