import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:ghioon_seller/Shared/language.dart';

import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'CustomBarChart/CustomBarCharLogic/ArrageByDateLogic.dart';
import 'CustomBarChart/CustomBarChart.dart';

class BarChartSample3 extends StatefulWidget {
  List views;
  int langIndex;
  BarChartSample3({super.key, required this.views, required this.langIndex});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {


  int langIndex = 0;
  int max = 0;
  String item = '';
  List items = [];
  List<List> listOfDateLists = [];
  @override
  void initState() {
    super.initState();
    langIndex = widget.langIndex;
    item = Language().day[langIndex];
    
    
    listOfDateLists = ArrageByDateLogic().calculation(widget.views, item,context,langIndex);
  }


  @override
  Widget build(BuildContext context) {
    max = ArrageByDateLogic().maxNumber();
     langIndex = widget.langIndex;
     items = [
      Language().day[langIndex],
      Language().week[langIndex],
      Language().month[langIndex],
      Language().year[langIndex],
    ];
    // print(FirebaseAuth.instance.currentUser?.uid ?? '');
     listOfDateLists = ArrageByDateLogic().calculation(widget.views, item,context,langIndex);
    return Scaffold(
      body: Padding(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
                child: Center(
                  child: Text(Language().store_view[langIndex],
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
                    labels: [
                      Language().day[langIndex],
                      Language().week[langIndex],
                      Language().month[langIndex],
                      Language().year[langIndex],
                    ],
                    onToggle: (index) {
                      setState(() {
                        item = items[index!];
                        max = 0;
                      });
                      print(item);
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
                                        Language().you_dont_have_order[langIndex],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
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
    );
  }
}
