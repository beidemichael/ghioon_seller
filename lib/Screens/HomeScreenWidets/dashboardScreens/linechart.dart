import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/dashboardScreens/graphPoints.dart';
import 'package:collection/collection.dart';

class LineGraphWiget extends StatefulWidget {
  final List<Point> points;
  const LineGraphWiget({super.key, required this.points});

  @override
  State<LineGraphWiget> createState() => _LineGraphWigetState();
}

class _LineGraphWigetState extends State<LineGraphWiget> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(LineChartData(
          borderData: FlBorderData(
            show: false,
            // border: Border.all(color: Colors.white, width: 2)
          ),
          lineBarsData: [
            LineChartBarData(
                spots: widget.points
                    .map((point) => FlSpot(point.x, point.y))
                    .toList(),
                isCurved: true,
                dotData: FlDotData(show: true))
          ])),
    );
  }
}
