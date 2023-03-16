import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Models/models.dart';
import '../../../../Shared/customColors.dart';

class CollectionPieChartChart extends StatefulWidget {
  const CollectionPieChartChart({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  List<PieChartSectionData> pieDataList = [];
  bool chartDrawn = false;
  List<int> percentCounter = [];
  List<int> percentCounterPercent = [];
  int total = 0;
  List<Color> color = [
    Colors.teal.shade300,
    Colors.red.shade300,
    Colors.purple.shade300,
    Colors.yellow.shade300,
    Colors.pink.shade300,
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.lime.shade300,
    Colors.orange.shade300,
    Colors.brown.shade300,
    Colors.deepOrange.shade300,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  initializeCollection(collection, products) {
    percentCounter.clear();
    for (int i = 0; i < collection.length; i++) {
      int counter = 0;
      for (int j = 0; j < products.length; j++) {
        if (products[j].Product_collection == collection[i]) {
          counter++;
        }
      }
      percentCounter.add(counter);
    }
    for (int i = 0; i < percentCounter.length; i++) {
      total = total + percentCounter[i];
    }
    for (int i = 0; i < percentCounter.length; i++) {
      percentCounterPercent.add(((percentCounter[i] / total) * 100).toInt());
    }
    pieDataList.clear();
    for (int i = 0; i < collection.length; i++) {
      pieDataList.add(
        PieChartSectionData(
          color: color[i],
          value: percentCounterPercent.isEmpty
              ? 100.0
              : percentCounterPercent[i].toDouble(),
          title: percentCounterPercent[i].toString() + '%',
          radius: 100,
          titleStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    final products = Provider.of<List<Product>>(context);
    if (userInfo.isNotEmpty && products.isNotEmpty) {
      initializeCollection(userInfo[0].collections, products);
    }
    return percentCounterPercent.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors().lightBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Collection Percentage',
                      style: TextStyle(
                          fontSize: 30,
                          color: CustomColors().darkBlue2,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                // touchedIndex = -1;
                                return;
                              }
                              if (touchedIndex ==
                                  pieTouchResponse
                                      .touchedSection!.touchedSectionIndex) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              }
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: pieDataList,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          border:
                              Border.all(width: 1, color: Color(0xFFC5C5C5)),
                          color: CustomColors().blue,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: userInfo[0].collections.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border:
                              Border.all(width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                                      shape: BoxShape.circle,
                                      color: color[index],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(userInfo[0].collections[index],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: CustomColors().black,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          );
  }
}
