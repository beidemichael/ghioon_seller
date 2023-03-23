import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Shared/customColors.dart';

import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'CustomBarChart/CustomBarCharLogic/ArrageByDateLogic.dart';
import 'CustomBarChart/CustomBarChart.dart';

class BarChartProductView extends StatefulWidget {
  List views;

  BarChartProductView({super.key, required this.views});

  @override
  State<StatefulWidget> createState() => BarChartProductViewState();
}

class BarChartProductViewState extends State<BarChartProductView> {
  int max = 0;
  String item = 'Day';
  var items = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  List listOfDateLists = [];

  @override
  Widget build(BuildContext context) {
    List<List> listOfDateLists =
        ArrageByDateLogic().calculation(widget.views, item);
    max = ArrageByDateLogic().maxNumber();
    print(FirebaseAuth.instance.currentUser?.uid ?? '');
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: CustomColors().lightBlue,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 17.0, vertical: 20),
                  child: Center(
                    child: Text('Product view',
                        style: TextStyle(
                            fontSize: 30,
                            color: CustomColors().darkBlue2,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    // border: Border.all(width: 1, color: Color(0xFFC5C5C5)),
                  ),
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 60.0,
                      fontSize: 16.0,
                      initialLabelIndex: items.indexOf(item),
                      activeBgColor: const [
                        Color.fromARGB(255, 0, 32, 7),
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: CustomColors().blue,
                      inactiveFgColor: CustomColors().darkBlue2,
                      totalSwitches: 4,
                      labels: const [
                        'Day',
                        'Week',
                        'Month',
                        'Year',
                      ],
                      onToggle: (index) {
                        setState(() {
                          item = items[index!];
                          max = 0;
                        });

                        print('switched to: $index');
                      },
                    ),
                  ),
                ),
                widget.views == null
                    ? const Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                          size: 50.0,
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            child: widget.views.isEmpty
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                          'You don\'t have any views yet.',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: CustomColors().darkBlue2,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  )
                                : Center(
                                    child: CustomBarChart(
                                      listOfDateLists: listOfDateLists,
                                      item: item,
                                    ),
                                  ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
