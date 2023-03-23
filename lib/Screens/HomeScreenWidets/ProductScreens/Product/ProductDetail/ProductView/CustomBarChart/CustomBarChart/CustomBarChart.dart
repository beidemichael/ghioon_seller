import 'package:flutter/material.dart';
import 'package:ghioon_seller/Shared/customColors.dart';
import 'package:provider/provider.dart';


import 'CustomBarCharLogic/ArrageByDateLogic.dart';
import 'CustomBarChartWidgets/BottomText.dart';

class CustomBarChart extends StatefulWidget {
  List<List> listOfDateLists;
  String item;

  CustomBarChart({
    super.key,
    required this.listOfDateLists,
    required this.item,
  });

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  int max = 0;
  checkMax(List<List> listOfDateLists) {
    setState(() {
      max = 0;
    });
    for (int i = 0; i < listOfDateLists.length; i++) {
      if (listOfDateLists[i].length > max) {
        setState(() {
          max = listOfDateLists[i].length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    checkMax(widget.listOfDateLists);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 17),
      child: Container(
        height: MediaQuery.of(context).size.width + 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(width: 1, color: Color(0xFFC5C5C5)),
          color: CustomColors().blue,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: widget.listOfDateLists.length,
          itemBuilder: (context, index) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width + 20,
                width: 90,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 50.0,
                      top: 0.0,
                      right: 0,
                      left: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              widget.listOfDateLists[index].length.toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 40,
                            height: MediaQuery.of(context).size.width - 50,
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              color:CustomColors().darkBlue2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50.0,
                      top: 0.0,
                      right: 0,
                      left: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: max == 0
                                ? 100
                                : ((widget.listOfDateLists[index].length /
                                        max) *
                                    ((MediaQuery.of(context).size.width) - 50)),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              color: Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: BottomText(
                            item: widget.item,
                            listOfDateLists: widget.listOfDateLists,
                            index: index)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
